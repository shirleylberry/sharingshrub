class AddLatitudeAndLongitudeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
    remove_column :events, :state
    remove_column :events, :zip
  end
end
