class Seller < ApplicationRecord
  belongs_to :user, optional: true
  has_many :tickets
  has_many :orders
  has_one :bank_account, dependent: :destroy
  # accepts_nested_attributes_for :bank_account
  mount_uploader :photo, ImageUploader
  validates :photo, :self_introduction, presence: true

  validates :first_name_kanji, :last_name_kanji, presence: true
  validates :first_name_kana, :last_name_kana, presence: true, format: { with: /\A[ぁ-んー－]+\z/ }
  validates :gender, :date_of_birth, presence: true
  validates :date_of_birth, length: { maximum: 10 }

  validates :address_kanji_state, :address_kanji_city, :address_kanji_town, :address_kanji_line, :address_kana_line, presence: true
  validates :address_kana_state, :address_kana_city, presence: true, format: { with: /\A[ぁ-んー－]+\z/ }
  validates :address_kana_town, presence: true, format: { with: /\A[ぁ-ん][ぁ-ん０-９0-9ー－-]+\z/ }

  validates :postal_code, presence: true, inclusion: { in: Area.pluck(:postal_code) }
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z|\A\d{11}\z/ }
  accepts_nested_attributes_for :bank_account

  enum gender: %i(male female)

  validate :photo_size
  validate :check_birth

    private
      def photo_size
        if photo.size > 20.megabytes
            errors.add(:picture, "サイズが20Mを超える写真はアップロードできません")
          end
      end

      def check_birth
        birth_day = Date.parse("#{date_of_birth}")
        today = Date.today
        if birth_day > today.ago(20.years)
          errors.add(:date_of_birth, "：20歳以下の方は登録できません")
        end
      end
end
