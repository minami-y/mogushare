class UserPoint::Buy < UserPoint
  def self.apply!(user:, used_amount:)
    return if used_amount.zero?

    ApplicationRecord.transaction do
      user_point = find_or_initialize_by(user_id: user.id)
      raise 'Over the available points' if user_point.amount < used_amount

      ApplicationRecord.transaction do
        user_point.update!(amount: user_point.amount - used_amount)
        UserPointLog.create_buy_log!(
          user: user,
          amount: used_amount,
        )
      end
    end
  end
end
