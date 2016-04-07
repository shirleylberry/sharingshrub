class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.integer :event_id
      t.integer :donor_id
      t.integer :amount
      t.boolean :pending
      t.timestamps null: false
    end
  end
end
