class AddFeeToDisbursements < ActiveRecord::Migration[6.0]
  def change
    add_column :disbursements, :fee, :decimal, :precision => 8, :scale => 2
  end
end
