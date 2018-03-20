require 'test_helper'

class UserPoint::InvitationOverflowTest < ActiveSupport::TestCase
  def setup
    @count = UserPointLog.count
    @before_amount = user_points(:nishisuke_point).amount
  end

  def test_apply
    point = 350
    UserPoint::InvitationOverflow.apply!(
      user: users(:nishisuke),
      add_amount: point,
    )

    assert_equal @before_amount + point, user_points(:nishisuke_point).reload.amount
    assert_equal @count + 1, UserPointLog.count
  end

  def test_0
    UserPoint::InvitationOverflow.apply!(
      user: users(:nishisuke),
      add_amount: 0,
    )

    assert_equal 300, user_points(:nishisuke_point).reload.amount
    assert_equal @count, UserPointLog.count
  end
end
