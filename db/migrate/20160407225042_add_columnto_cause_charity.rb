class AddColumntoCauseCharity < ActiveRecord::Migration
  def change
    add_column :cause_charities, :cause_id, :integer
    add_column :cause_charities, :charity_id, :integer
  end
end
