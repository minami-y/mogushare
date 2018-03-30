class Ticket < ApplicationRecord
  belongs_to :seller, optional: true
  belongs_to :user, optional: true
  has_many :shares, dependent: :destroy
  accepts_nested_attributes_for :shares, allow_destroy: true
  validates :event_date, presence: true
  validates :event_end_date, presence: true
  validates :expiration_date, presence: true
  validates :genre, presence: true
  validates :event_place, presence: true
end
