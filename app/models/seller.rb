class Seller < ApplicationRecord
  belongs_to :user, optional: true
  has_many :tickets
  has_many :orders
  mount_uploader :photo, ImageUploader
  validates :photo, presence: true
  validates :self_introduction, presence: true
end
