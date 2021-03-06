class Share < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :ticket, optional: true
  has_many :order_details
  validates :menu, presence: true
  validates :price, numericality: { only_integer: true}, presence: true
  validates :quantity, presence: true
  validates :message, presence: true

  # 金額が全角数字で入力された際に半角数字に変換する。
  def price=(value)
    value.tr!('０-９', '0-9') if value.is_a?(String)
    super(value)
  end
end
