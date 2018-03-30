class Order < ApplicationRecord
  belongs_to :user
  belongs_to :seller
  has_many :order_details, dependent: :destroy
  accepts_nested_attributes_for :order_details, allow_destroy: true

  validates :user_id, :seller_id, :stripe_charge_id, presence: true
end
