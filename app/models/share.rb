class Share < ApplicationRecord
  belongs_to :ticket, optional: true
  validates :genre, presence: true
  validates :menu, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end
