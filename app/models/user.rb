class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  before_save :build_invitation_code

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255},
              format: { with: VALID_EMAIL_REGEX},
              uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :password, presence: false, on: :facebook_login
  mount_uploader :image, ImageUploader
  has_many :user_areas
  has_many :area, through: :user_areas
  accepts_nested_attributes_for :user_areas
  has_one :seller
  has_many :tickets
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :talks
  has_many :authorizations
  has_one  :user_invitation_code
  has_one  :user_point
  has_many :user_point_logs

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

# ブラウザ再起動後でもすぐにログインできる機能（永続セッション）に関するメソッド
  # 記憶トークンを生成する。
  def User.new_token
    SecureRandom.urlsafe_base64
  end


  # 永続セッションのためにユーザーをDBに記憶する。
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を削除
  def forget
    update_attribute(:remember_digest, nil)
  end

  def self.from_omniauth(auth)
    # where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user = User.where('email=?', auth.info.email).first
    if user.nil?
      user = User.new
    end
    # where(auth.uid, auth.provider).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user
    # end
  end

  private

  def build_invitation_code
    if user_invitation_code.nil?
      build_user_invitation_code
    end
  end
end
