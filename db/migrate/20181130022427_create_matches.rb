class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.integer :state_id
      t.integer :sender_slot_id
      t.integer :recipient_slot_id

      t.timestamps
    end
  end
end
