class AddTransactionIdColumnToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :transaction_id, :string
  end
end
