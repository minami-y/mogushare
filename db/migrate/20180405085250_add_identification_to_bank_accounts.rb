class AddIdentificationToBankAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :bank_accounts, :identification, :string
  end
end
