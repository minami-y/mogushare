class UserPoint::Invitation < UserPoint
  def self.apply!(introducer:, new_user:)
    ApplicationRecord.transaction do
      user_point = find_or_initialize_by(user_id: introducer.id)

      ApplicationRecord.transaction do
        user_point.update!(amount: user_point.amount + 500)
        UserPointLog.create_invitation_log!(
          introducer: introducer,
          new_user: new_user
        )
      end
    end
  end
end
