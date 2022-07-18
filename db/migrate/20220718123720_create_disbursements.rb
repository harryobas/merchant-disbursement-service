class CreateDisbursements < ActiveRecord::Migration[6.0]
  def change
    create_table :disbursements do |t|
      t.references :merchant, null: false, foreign_key: true
      t.integer :week

      t.timestamps
    end
  end
end
