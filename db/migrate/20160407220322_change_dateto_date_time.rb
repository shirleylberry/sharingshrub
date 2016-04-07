class ChangeDatetoDateTime < ActiveRecord::Migration
  def change
    remove_column :events,  :event_start_time
    remove_column :events,  :event_end_time
    remove_column :events,  :event_start_date
    remove_column :events,  :event_end_date

    add_column :events, :event_start, :datetime 
    add_column :events, :event_end, :datetime 
  end
end
