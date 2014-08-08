module Dovecote
  class StatusesController < ApplicationController
    def update
      params.require(:id)
      params.require(:recipient)
      params.require(:status)
      params.require(:statusDatetime)

      messages = Message.where(bird_id: params[:id], recipient: params[:recipient])
      messages.each do |m|
        m.update!({
          status: params[:status],
          status_changed_at: params[:statusDatetime]
        })
      end
      head :ok
    end
  end
end
