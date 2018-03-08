class AddImageToShares < ActiveRecord::Migration[5.0]
  def change
    add_column :shares, :image, :string
  end
end
