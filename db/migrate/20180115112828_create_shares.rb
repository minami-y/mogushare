class CreateShares < ActiveRecord::Migration[5.0]
  def change
    create_table :shares do |t|
      t.string :genre
      t.string :menu, null: false
      t.integer :price, null: false
      t.integer :quantity, null: false
      t.references :ticket

      t.timestamps
    end
  end
end
