# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_two'

class DayNinePartTwoTest < Minitest::Test
  def data
    <<~DATA
      XXX
    DATA
  end

  def test_run_length_encode
    test_cases = {
      '12345' => [[1, 0],
                  [2, -1],
                  [3, 1],
                  [4, -1],
                  [5, 2]],
      '2333133121414131402' => [[2, 0],
                                [3, -1],
                                [3, 1],
                                [3, -1],
                                [1, 2],
                                [3, -1],
                                [3, 3],
                                [1, -1],
                                [2, 4],
                                [1, -1],
                                [4, 5],
                                [1, -1],
                                [4, 6],
                                [1, -1],
                                [3, 7],
                                [1, -1],
                                [4, 8],
                                [2, 9]]
    }
    test_cases.each do |input, expected|
      disk_map = DayNine::PartOne.load_diskmap(input)
      blocks = DayNine::PartOne.expand_blocks(disk_map)
      result = DayNine::PartTwo.run_length_encode(blocks)

      assert_equal(expected, result)
    end
  end

  def test_compress_files
    test_cases = {
      '2333133121414131402' => '00992111777.44.333....5555.6666.....8888..'
    }
    test_cases.each do |input, expected|
      disk_map = DayNine::PartOne.load_diskmap(input)
      blocks = DayNine::PartOne.expand_blocks(disk_map)
      encoded = DayNine::PartTwo.run_length_encode(blocks)
      result = DayNine::PartTwo.compress_files(encoded)

      assert_equal(expected, result.map do |(count, value)|
        (value == -1 ? '.' : value.to_s) * count
      end.join)
    end
  end

  def test_run
    result = DayNine::PartTwo.run('2333133121414131402')

    assert_equal(2858, result)
  end
end
