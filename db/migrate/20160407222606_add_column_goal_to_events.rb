class AddColumnGoalToEvents < ActiveRecord::Migration
  def change
    add_column :events, :goal, :float
  end
end
