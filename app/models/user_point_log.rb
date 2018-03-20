class UserPointLog < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true, numericality: { only_integer: true }

  enum reason_id: { invitation: 1, buy: 2, invitation_overflow: 3 }

  class << self
    def create_invitation_log!(introducer:, new_user:)
      introducer.user_point_logs.create!(
        reason_id: UserPointLog::reason_ids[:invitation],
        amount: 500,
        detail: "Invite user (id = #{new_user.id})",
      )
    end

    def create_buy_log!(user:, amount:)
      user.user_point_logs.create!(
        reason_id: UserPointLog::reason_ids[:buy],
        amount: amount,
        detail: "Use #{amount} point",
      )
    end

    def create_invitation_overflow_log!(user:, amount:)
      user.user_point_logs.create!(
        reason_id: UserPointLog::reason_ids[:invitation_overflow],
        amount: amount,
        detail: "Invitation points overflow #{amount} point",
      )
    end
  end
end
