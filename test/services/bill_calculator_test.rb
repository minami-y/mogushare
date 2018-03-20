require 'test_helper'

class BillCalculatorTest < ActiveSupport::TestCase
  def default_args
    {
      user: users(:michael),
      total_amount: 1000,
      code: user_invitation_codes(:nishisuke_code).code,
      used_point: 0,
    }
  end

  def service_setup(args = {})
    args = default_args.merge(args)
    @service = BillCalculator.new(
      args[:user],
      args[:total_amount],
      args[:code],
      args[:used_point],
    )
  end

  def test_with_valid_code
    service_setup(used_point: 200)
    result = @service.amount
    assert_equal 300, result
    assert_equal 0, @service.add_user_point
    assert @service.is_code_used
    assert_equal 200, @service.used_point
  end

  def test_with_self_code
    service_setup(user: users(:nishisuke))
    result = @service.amount
    assert_equal 1000, result
    assert_equal 0, @service.add_user_point
    refute @service.is_code_used
  end

  def test_with_invalid_code
    service_setup(code: 'invefjdakf')
    result = @service.amount
    assert_equal 1000, result
    assert_equal 0, @service.add_user_point
    refute @service.is_code_used
  end

  def test_already_used_code
    service_setup(user: users(:archer))
    result = @service.amount
    assert_equal 1000, result
    assert_equal 0, @service.add_user_point
    refute @service.is_code_used
  end

  def test_with_overflow_amount
    service_setup(total_amount: 200)
    result = @service.amount
    assert_equal 0, result
    assert_equal 300, @service.add_user_point
    assert @service.is_code_used
  end

  def test_with_minus_point
    service_setup(used_point: -333, code: nil)
    assert_raise RuntimeError do
      result = @service.amount
    end
  end

  def test_with_dont_have_point
    service_setup(used_point: 1000, code: nil)
    assert_raise RuntimeError do
      result = @service.amount
    end
  end

  def test_with_too_much_point
    service_setup(used_point: 300, total_amount: 200, code: nil)
    result = @service.amount
    assert_equal 0, result
    assert_equal 200, @service.used_point
  end
end
