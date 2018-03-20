require 'test_helper'

class UserPoint::InvitationTest < ActiveSupport::TestCase
  def setup
    @count = UserPointLog.count
    @before_amount = user_points(:nishisuke_point).amount
  end

  def test_apply
    UserPoint::Invitation.apply!(
      introducer: users(:nishisuke),
      new_user: users(:michael),
    )

    assert_equal @before_amount + 500, user_points(:nishisuke_point).reload.amount
    assert_equal @count + 1, UserPointLog.count
  end
end
