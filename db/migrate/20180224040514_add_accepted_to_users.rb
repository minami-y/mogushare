class AddAcceptedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :accepted, :boolean
  end
end
