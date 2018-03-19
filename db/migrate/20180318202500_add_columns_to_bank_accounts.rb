class AddColumnsToBankAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :bank_accounts, :bank_code, :integer
  end
end
