class Area < ApplicationRecord
  acts_as_mappable default_units: :kms

  belongs_to :prefectural
  has_many :user_areas
  has_many :users, through: :user_areas

  def self.search(search)
    if search
      Area.find_by(postal_code: "#{search}")
    end
  end
end
