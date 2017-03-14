module Dovecote
  class StatusesController < ApplicationController

    # /dovecote/update_status?mccmnc=26001&ported=0&id=654d9a79558c7f7ee2e5004b40436180&reference=xxx&recipient=48697234015&status=delivered&statusDatetime=2017-03-14T14%3A02%3A24%2B00%3A00
    def update
      params.require(:id)
      params.require(:recipient)
      params.require(:status)
      params.require(:statusDatetime)

      Message.where(bird_id: params[:id], msisdn: params[:recipient]).each do |m|
        m.update!({
          status:            params[:status],
          status_changed_at: params[:statusDatetime]
        })
      end
      head :ok
    end
  end
end
