class AddDefaultValueToFundedEvents < ActiveRecord::Migration
  def change
    change_column :events, :funded, :boolean, :default => false
  end
end
