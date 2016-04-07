class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :event_start_date
      t.date :event_end_date
      t.time :event_start_time
      t.time :event_end_time
      t.integer :host_id
      t.timestamps null: false
    end
  end
end
