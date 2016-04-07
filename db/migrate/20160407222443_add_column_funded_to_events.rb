class AddColumnFundedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :funded, :boolean 
  end
end
