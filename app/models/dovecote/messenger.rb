require "messagebird"

module Dovecote
  class Messenger
    include Singleton

    def client
      @client ||= MessageBird::Client.new(Dovecote.access_key)
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

    def create_message(msisdn, body, options = {})
      originator = Dovecote.originator || "SMS"
      options.reverse_merge!({datacoding: Dovecote.unicode ? "unicode" : "plain"})

      begin
        message = client.message_create(originator, msisdn, body, options)
        message.recipients["items"].each do |item|
          Message.create!({
            bird_id:            message.id,
            msisdn:             item.recipient.to_s,
            body:               message.body,
            originator:         message.originator,
            reference:          message.reference,
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
