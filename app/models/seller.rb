class Seller < ApplicationRecord
  belongs_to :user, optional: true
  has_many :tickets
end
