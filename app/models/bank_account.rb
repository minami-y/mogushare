class BankAccount < ApplicationRecord
  belongs_to :seller, optional: true

  validates :bank, :account_type, :branch_code, :account_number, :name, :bank_code, presence: true
  validates :bank_code, length: { is: 4 }
  validates :branch_code, length: { is: 3 }
  validates :account_number, length: { in: 6..8 }
  mount_uploader :identification, ImageUploader
  validates :identification, presence: true

  enum account_type: %i(normal current)

end
