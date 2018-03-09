class AddMessageToShares < ActiveRecord::Migration[5.0]
  def change
    add_column :shares, :message, :text
  end
end
