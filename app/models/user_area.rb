class UserArea < ApplicationRecord
  belongs_to :user
  belongs_to :area

  validates :user_id, uniqueness: { scope: :area_id }
end
