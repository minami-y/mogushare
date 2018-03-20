class UserInvitationCode < ApplicationRecord
  belongs_to :user

  before_create :set_unique_code

  def another_user_code?(user)
    user_id != user.id
  end

  private

  def set_unique_code
    self.code = self.class.unique_code
  end

  def self.unique_code
    code = generate_code
    while exists?(code: code)
      code = generate_code
    end
    code
  end

  def self.generate_code
    "mogmog_#{Time.now.to_i}"
  end
end
