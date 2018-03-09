class CreateBankAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_accounts do |t|
        t.string :bank, null: false, default: ""
        t.integer :account_type, null: false, default: 0
        t.string :branch_code, null: false, default: ""
        t.string :account_number, null: false, default: ""
        t.string :name, null: false, default: ""
        t.references :seller, null: false, foreign_key: true
        t.timestamps
    end
  end
end
