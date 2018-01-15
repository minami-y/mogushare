class Area < ApplicationRecord
  belongs_to :prefectural
  has_many :user_areas
  has_many :users, through: :user_areas

  def self.search(search)
    if search
      Area.where(['postal_code LIKE ?', "%#{search}%"])
    else
      flash[:danger] = "該当するエリアはありませんでした。"
      redirect_to root_path
    end
  end
end
