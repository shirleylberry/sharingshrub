class ChangeColumnPendingToStatus < ActiveRecord::Migration
  def change
    remove_column :pledges, :pending 
    add_column :pledges, :status, :string
  end
end
