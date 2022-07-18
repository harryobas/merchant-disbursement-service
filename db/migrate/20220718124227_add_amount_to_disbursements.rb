class AddAmountToDisbursements < ActiveRecord::Migration[6.0]
  def change
    add_column :disbursements, :amount, :decimal, :precision => 8, :scale => 2
  end
end
