class CreateDovecoteMessages < ActiveRecord::Migration[6.0]
  def change
    # https://developers.messagebird.com/docs/messaging
    create_table :dovecote_messages do |t|
      t.string :body
      t.string :originator, null: false
      t.string :msisdn, null: false
      t.string :reference
      t.string :bird_id, null: false
      t.string :status, null: false

      t.datetime :scheduled_at
      t.datetime :sent_at
      t.datetime :buffered_at
      t.datetime :delivered_at
      t.datetime :expired_at
      t.datetime :delivery_failed_at

      t.timestamps
    end
  end
end
