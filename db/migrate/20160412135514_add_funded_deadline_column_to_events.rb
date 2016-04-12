class AddFundedDeadlineColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :funded_deadline, :datetime
  end
end
