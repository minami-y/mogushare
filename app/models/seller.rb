class Seller < ApplicationRecord
  belongs_to :user, optional: true
  has_many :tickets
  has_many :orders
  has_one :bank_account, dependent: :destroy
  # accepts_nested_attributes_for :bank_account
  mount_uploader :photo, ImageUploader
  validates :photo, presence: true
  validates :self_introduction, presence: true

  accepts_nested_attributes_for :bank_account
end
