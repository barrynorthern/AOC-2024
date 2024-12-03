# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/day_one_part_one'

class DayOnePartOneTest < Minitest::Test
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

  def test_get_lists_from_data
    list_left, list_right = DayOne::PartOne.get_lists_from_data(data)

    assert_equal([3, 4, 2, 1, 3, 3], list_left)
    assert_equal([4, 3, 5, 3, 9, 3], list_right)
  end

  def test_can_return_the_correct_result
    result = DayOne::PartOne.run(data)

    assert_equal(11, result)
  end
end
