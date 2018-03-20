require 'test_helper'

class UserPoint::BuyTest < ActiveSupport::TestCase
  def setup
    @count = UserPointLog.count
  end

  def test_apply
    UserPoint::Buy.apply!(
      user: users(:nishisuke),
      used_amount: 200,
    )

    assert_equal 100, user_points(:nishisuke_point).reload.amount
    assert_equal @count + 1, UserPointLog.count
  end

  def test_apply_too_match_point
    assert_raise RuntimeError do
      UserPoint::Buy.apply!(
        user: users(:nishisuke),
        used_amount: 200000,
      )
    end
    assert_equal @count, UserPointLog.count
  end

  def test_0
    UserPoint::Buy.apply!(
      user: users(:nishisuke),
      used_amount: 0,
    )

    assert_equal 300, user_points(:nishisuke_point).reload.amount
    assert_equal @count, UserPointLog.count
  end
end
