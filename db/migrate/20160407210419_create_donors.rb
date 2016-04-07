class CreateDonors < ActiveRecord::Migration
  def change
    create_table :donors do |t|
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
