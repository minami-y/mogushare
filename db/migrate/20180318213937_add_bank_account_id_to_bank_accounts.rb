class AddBankAccountIdToBankAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :bank_accounts, :bank_account_id, :string
    add_column :bank_accounts, :string, :string
  end
end
