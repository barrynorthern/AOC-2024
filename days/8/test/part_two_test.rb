# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_two'

class DayEightPartTwoTest < Minitest::Test
  def test_run
    map = DayEight::PartOne.process_data(DayEightPartOneTest.data)
    num_antinodes = DayEight::PartTwo.run(map)

    assert_equal(34, num_antinodes)
  end
end
