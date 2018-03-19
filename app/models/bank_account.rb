class BankAccount < ApplicationRecord
  belongs_to :seller, optional: true

  validates :bank, :account_type, :branch_code, :account_number, :name, :bank_code, presence: true
end
