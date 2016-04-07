class CreateEventCharities < ActiveRecord::Migration
  def change
    create_table :event_charities do |t|
      t.integer :event_id
      t.integer :charity_id
      t.timestamps null: false
    end
  end
end
