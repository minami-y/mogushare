class RemoveColumnFromShares < ActiveRecord::Migration[5.0]
  def change
    remove_column :shares, :genre
  end
end
