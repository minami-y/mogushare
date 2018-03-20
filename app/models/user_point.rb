class UserPoint < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true, numericality: { only_integer: true }
end
