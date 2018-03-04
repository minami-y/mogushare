class RemoveColumnFromSeller < ActiveRecord::Migration[5.0]
  def change
    remove_column :sellers, :official_name, :string
    remove_column :sellers, :address, :string
    remove_column :sellers, :phone_number, :string
  end
end
