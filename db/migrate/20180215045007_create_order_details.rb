class CreateOrderDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :order_details do |t|
      t.references :share
      t.references :order
      t.integer :unit_price
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end
