class Ticket < ApplicationRecord
  belongs_to :seller
  belongs_to :user
  has_many :shares, dependent: :destroy
  accepts_nested_attributes_for
end
