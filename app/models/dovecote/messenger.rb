require "messagebird"

module Dovecote
  class Messenger
    include Singleton

    def client
      @client ||= MessageBird::Client.new(Dovecote.access_key)
    end

    def datacoding
      Dovecote.unicode ? "unicode" : "plain"
    end

    def update_status(message)
      begin
        message = client.message(message.bird_id)
        message.recipients["items"].each do |item|
          Message.where(bird_id: message.id, recipient: item.recipient.to_s).each do |m|
            m.update!(status: item.status, status_changed_at: item.statusDatetime)
          end
        end
      rescue MessageBird::ErrorException => e
        raise e.errors.first.description
      end
    end

    def create_message(msisdn, body, reference = nil)
      originator = Dovecote.originator || "SMS"
      options = {reference:  reference, datacoding: datacoding}

      begin
        message = client.message_create(originator, msisdn, body, options)
        message.recipients["items"].each do |item|
          Message.create!({
            body:               message.body,
            originator:         message.originator,
            bird_id:            message.id,
            reference:          (message.reference if message.reference.present?),
            recipient:          item.recipient.to_s,
            status:             item.status,
            status_changed_at:  item.statusDatetime
          })
        end
      rescue MessageBird::ErrorException => e
        raise e.errors.first.description
      end
    end
  end
end
