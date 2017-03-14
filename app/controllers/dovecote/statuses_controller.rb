module Dovecote
  class StatusesController < ApplicationController

    # GET http://your-own.url/script
    # ?id=e8077d803532c0b5937c639b60216938
    # &msisdn=31612345678
    # &reference=YourReference
    # &status=active
    # &createdDatetime=2016-05-04T07:32:46+00:00
    # &statusDatetime=2016-05-04T07:32:46+00:00
    def update
      params.require(:id)
      params.require(:msisdn)
      params.require(:status)
      params.require(:statusDatetime)

      Message.where(bird_id: params[:id], msisdn: params[:msisdn]).each do |m|
        m.update!({
          status:            params[:status],
          status_changed_at: params[:statusDatetime]
        })
      end
      head :ok
    end
  end
end
