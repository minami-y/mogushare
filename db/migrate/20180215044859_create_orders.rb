class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user
      t.references :seller
      t.integer :total_price

      t.timestamps
    end
  end
end
