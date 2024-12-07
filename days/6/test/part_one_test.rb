# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_one'
# require_relative '../lib/guard'
# require_relative '../lib/map'#

class DaySixPartOneTest < Minitest::Test
  def self.data
    <<~DATA
      ....#.....
      .........#
      ..........
      ..#.......
      .......#..
      ..........
      .#..^.....
      ........#.
      #.........
      ......#...
    DATA
  end

  def test_run
    result = DaySix::PartOne.run(DaySixPartOneTest.data)

    assert_equal(41, result)
  end
end
