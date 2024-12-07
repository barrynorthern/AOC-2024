# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_two'

class DaySixPartTwoTest < Minitest::Test
  def test_run
    result = DaySix::PartTwo.run(DaySixPartOneTest.data)

    assert_equal(6, result)
  end
end
