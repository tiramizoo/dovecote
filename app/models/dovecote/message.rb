module Dovecote
  class Message < ActiveRecord::Base
    attr_accessor :status_changed_at

    validates :body,       presence: true
    validates :originator, presence: true
    validates :bird_id,    presence: true
    validates :recipient,  presence: true
    validates :status,     presence: true, inclusion: {in: %w(scheduled sent buffered delivered delivery_failed)}

    def status_changed_at=(datetime)
      return unless status
      send(:"#{status}_at=", datetime)
    end
  end
end

