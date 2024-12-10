# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_two'

class DayTenPartTwoTest < Minitest::Test
  def test_run
    grid = DayTen::PartOne.process_data(DayTenPartOneTest.data)
    result = DayTen::PartTwo.run(grid)

    assert_equal(81, result)
  end
end
