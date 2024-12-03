# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/day_three_part_one'

class DayThreePartOneTest < Minitest::Test
  def data
    <<~DATA
      xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    DATA
  end

  def test_sum_valid_muls_from_data
    sum = DayThree::PartOne.sum_valid_muls_from_data(data)

    assert_equal(161, sum)
  end
end
