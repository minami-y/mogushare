class BillCalculator
  # 招待コードは500円引き
  INVITATION_CODE_DISCOUNT = 500

  attr_accessor :user, :code, :used_point, :payed_amount, :add_user_point, :invitation_code, :is_code_used

  def initialize(user, total_amount, code, used_point)
    @user = user
    @code = code
    @used_point = used_point
    @payed_amount = total_amount
    @add_user_point = 0
    @is_code_used = false
  end

  def amount
    apply_invitation_code

    apply_point

    payed_amount
  end

  def apply!
    ApplicationRecord.transaction do
      UserPoint::InvitationOverflow.apply!(
        user: user,
        add_amount: add_user_point,
      )

      UserPoint::Buy.apply!(
        user: user,
        used_amount: used_point,
      )

      if is_code_used
        user.update!(use_invitation_code: true)
        UserPoint::Invitation.apply!(
          introducer: invitation_code.user,
          new_user: user,
        )
      end
    end
  rescue => e
    logger.error e
    logger.info self
  end

  private

  def apply_point
    raise 'use positive point' if used_point < 0
    return if used_point.zero?
    raise 'Your available point is less than input' if user.find_or_create_user_point!.amount < used_point

    if used_point > @payed_amount
      @used_point = payed_amount
    end

    @payed_amount -= used_point
  end

  def apply_invitation_code
    return unless valid_invitation_code?
    return if user.use_invitation_code # already use a code

    @is_code_used = true

    @payed_amount -= INVITATION_CODE_DISCOUNT

    if payed_amount < 0
      @add_user_point =  -1 * payed_amount

      @payed_amount = 0
    end
  end

  def valid_invitation_code?
    @invitation_code = UserInvitationCode.find_by(code: code)

    return false if invitation_code.nil?

    invitation_code.another_user_code?(user)
  end

  def logger
    @logger ||= Logger.new('log/point.log', 'weekly')
  end
end
