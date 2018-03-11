class BankAccount < ApplicationRecord
  belongs_to :seller, optional: true
end
