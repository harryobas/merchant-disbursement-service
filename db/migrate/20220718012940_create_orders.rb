class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :merchant, null: false, foreign_key: true
      t.references :shopper, null: false, foreign_key: true
      t.datetime :completed_at

      t.timestamps
    end
  end
end
