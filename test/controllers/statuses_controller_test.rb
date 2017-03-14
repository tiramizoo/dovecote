require 'test_helper'

module Dovecote
  class StatusesControllerTest < ActionController::TestCase

    setup do
      @routes = Engine.routes
    end

    test "update raises error when required parameters are missing" do
      assert_raises ActionController::ParameterMissing do
        get :update
      end
    end

    test "update" do
      message = Message.create!({
        bird_id:   "1",
        msisdn:    "48322100000",
        body:      "test",
        status:    "sent",
        originator: "TEST",
        sent_at:   "2014-07-31T12:00:00+00:00"
      })

      params = {
        id:             message.bird_id,
        recipient:      message.msisdn,
        status:         "delivered",
        statusDatetime: "2014-07-31T12:01:00+00:00"
      }

      get(:update, params)
      assert_response :success

      message.reload

      assert_equal "delivered", message.status
      assert_equal "2014-07-31T12:01:00+00:00", message.delivered_at.to_datetime.rfc3339
    end
  end
end
