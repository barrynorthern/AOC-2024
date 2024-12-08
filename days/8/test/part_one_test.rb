# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_one'

class DayEightPartOneTest < Minitest::Test
  def data
    <<~DATA
      ............
      ........0...
      .....0......
      .......0....
      ....0.......
      ......A.....
      ............
      ............
      ........A...
      .........A..
      ............
      ............
    DATA
  end

  def test_process_data
    map = DayEight::PartOne.process_data(data)

    refute_nil(map)
    assert_equal({ '0' => [20, 29, 43, 52], 'A' => [66, 104, 117] }, map.nodes)
  end

  def test_run
    map = DayEight::PartOne.process_data(data)
    num_antinodes = DayEight::PartOne.run(map)

    assert_equal(14, num_antinodes)
  end
end
