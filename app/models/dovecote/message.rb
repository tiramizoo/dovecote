module Dovecote
  class Message < ActiveRecord::Base
    attr_accessor :status_changed_at

    Statuses = %w(scheduled sent buffered delivered expired delivery_failed)

    validates :body,       presence: true
    validates :originator, presence: true
    validates :bird_id,    presence: true
    validates :msisdn,     presence: true
    validates :status,     presence: true, inclusion: {in: Statuses}

    Statuses.each do |status|
      scope status.to_sym, -> { where(status: status) }
    end

    def status_changed_at=(datetime)
      return unless status
      send(:"#{status}_at=", datetime)
    end
  end
end

