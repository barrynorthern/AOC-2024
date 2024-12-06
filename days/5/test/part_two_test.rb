# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_two'

class DayFivePartTwoTest < Minitest::Test
  def test_order_update
    rules, updates = DayFive::PartOne.process_data(DayFivePartOneTest.data)
    test_cases = {
      updates[3] => [97, 75, 47, 61, 53],
      updates[4] => [61, 29, 13],
      updates[5] => [97, 75, 47, 29, 13]
    }
    test_cases.each do |input, expected|
      result = DayFive::PartTwo.order_update_until_valid(rules, input)

      assert_equal(expected, result.keys)
    end
  end

  def test_get_sum_of_invalid_ordered_middle_updates
    rules, updates = DayFive::PartOne.process_data(DayFivePartOneTest.data)
    result = DayFive::PartTwo.get_sum_of_invalid_ordered_middle_updates(rules, updates)

    assert_equal(123, result)
  end
end
