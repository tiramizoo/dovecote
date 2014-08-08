class CreateDovecoteMessages < ActiveRecord::Migration
  def change
    create_table :dovecote_messages do |t|
      t.string :body
      t.string :originator, null: false
      t.string :recipient, null: false
      t.string :reference
      t.string :bird_id, null: false
      t.string :status, null: false

      %w(scheduled sent buffered delivered delivery_failed).each do |status|
        t.datetime :"#{status}_at", :datetime
      end
    end
  end
end
