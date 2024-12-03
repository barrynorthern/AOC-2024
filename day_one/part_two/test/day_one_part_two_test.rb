# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/day_one_part_two'

class DayOnePartTwoTest < Minitest::Test
  def data
    <<~DATA
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
    DATA
  end

  def test_can_return_the_correct_result
    result = DayOne::PartTwo.run(data)

    assert_equal(31, result)
  end
end
