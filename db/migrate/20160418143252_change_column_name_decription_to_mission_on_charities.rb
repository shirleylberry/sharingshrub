class ChangeColumnNameDecriptionToMissionOnCharities < ActiveRecord::Migration
  def change
    rename_column :charities, :description, :mission
  end
end
