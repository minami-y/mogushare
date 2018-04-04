class ChangeDatatypeBankCodeOfBankAccounts < ActiveRecord::Migration[5.0]
  def change
    change_column :bank_accounts, :bank_code, :string
  end
end
