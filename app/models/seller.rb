class Seller < ApplicationRecord
  belongs_to :user, optional: true
  has_many :tickets
  has_many :orders
  has_one :bank_account, dependent: :destroy
  # accepts_nested_attributes_for :bank_account
  mount_uploader :photo, ImageUploader
  validates :photo, presence: true
  validates :self_introduction, presence: true

  validates :address_kana_state, :address_kana_city, :first_name_kana, :last_name_kana, presence: true, format: { with: /\A[ぁ-んー－]+\z/ }

  validates :address_kana_town, presence: true, format: { with: /\A[ぁ-ん][ぁ-ん０-９0-9ー－-]+\z/ }

  validates :address_kanji_state, :address_kanji_city, :address_kanji_town, :address_kanji_line, :address_kana_line, :first_name_kanji, :last_name_kanji, :gender, :date_of_birth, presence: true

  validates :phone_number, presence: true, format: { with: /\A\d{10}\z|\A\d{11}\z/ }

  validates :postal_code, presence: true, inclusion: { in: Area.pluck(:postal_code) }

  accepts_nested_attributes_for :bank_account

  enum gender: %i(male female)
end
