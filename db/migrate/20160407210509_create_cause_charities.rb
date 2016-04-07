class CreateCauseCharities < ActiveRecord::Migration
  def change
    create_table :cause_charities do |t|

      t.timestamps null: false
    end
  end
end
