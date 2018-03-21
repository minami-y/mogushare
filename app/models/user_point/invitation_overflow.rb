class UserPoint::InvitationOverflow < UserPoint
  def self.apply!(user:, add_amount:)
    return if add_amount.zero?

    ApplicationRecord.transaction do
      user_point = find_or_initialize_by(user_id: user.id)

      ApplicationRecord.transaction do
        user_point.update!(amount: user_point.amount + add_amount)
        UserPointLog.create_buy_log!(
          user: user,
          amount: add_amount,
        )
      end
    end
  end
end
