class Order < ApplicationRecord
  belongs_to :user
  belongs_to :seller
  has_many :order_details
  accepts_nested_attributes_for :order_details, allow_destroy: true
end
