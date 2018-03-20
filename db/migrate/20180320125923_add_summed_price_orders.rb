class AddSummedPriceOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :summed_price, :integer
  end
end
