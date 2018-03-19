class AddColumnsToSellers < ActiveRecord::Migration[5.0]
  def change
    add_column :sellers, :stripe_account_id, :string
  end
end
