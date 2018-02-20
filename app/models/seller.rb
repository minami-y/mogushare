class Seller < ApplicationRecord
  belongs_to :user, optional: true
  has_many :tickets
  has_many :orders
  validates :official_name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
end
