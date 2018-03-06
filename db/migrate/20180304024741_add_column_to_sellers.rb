class AddColumnToSellers < ActiveRecord::Migration[5.0]
  def change
    add_column :sellers, :self_introduction, :text
    add_column :sellers, :photo, :string
    add_column :sellers, :sns_info, :string
  end
end
