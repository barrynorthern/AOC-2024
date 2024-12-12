# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_one'

class DayElevenPartOneTest < Minitest::Test
  def data
    <<~DATA
      125 17
    DATA
  end

  def test_run
    stones = DayEleven::PartOne.process_data(data)
    result = DayEleven::PartTwo.run(stones, 25)

    assert_equal(55_312, result)
  end
end
