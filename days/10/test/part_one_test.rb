# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_one'

class DayTenPartOneTest < Minitest::Test
  def self.data
    <<~DATA
      89010123
      78121874
      87430965
      96549874
      45678903
      32019012
      01329801
      10456732
    DATA
  end

  def test_run
    grid = DayTen::PartOne.process_data(DayTenPartOneTest.data)
    result = DayTen::PartOne.run(grid)

    assert_equal(36, result)
  end
end
