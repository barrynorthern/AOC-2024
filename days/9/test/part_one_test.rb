# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_one'

class DayNinePartOneTest < Minitest::Test
  def test_expand_blocks
    test_cases = {
      '12345' => '0..111....22222',
      '2333133121414131402' => '00...111...2...333.44.5555.6666.777.888899'
    }
    test_cases.each do |input, expected|
      disk_map = DayNine::PartOne.load_diskmap(input)
      result = DayNine::PartOne.expand_blocks(disk_map)

      assert_equal(expected.chars.map { |c| c == '.' ? -1 : c.to_i }, result)
    end
  end

  def test_compress_blocks
    test_cases = {
      '12345' => '022111222......',
      '2333133121414131402' => '0099811188827773336446555566..............'
    }
    test_cases.each do |input, expected|
      disk_map = DayNine::PartOne.load_diskmap(input)
      blocks = DayNine::PartOne.expand_blocks(disk_map)
      result = DayNine::PartOne.compress_blocks(blocks)

      assert_equal(expected, result.map { |c| c == -1 ? '.' : c.to_s }.join)
    end
  end

  def test_checksum
    disk_map = DayNine::PartOne.load_diskmap('2333133121414131402')
    blocks = DayNine::PartOne.expand_blocks(disk_map)
    compressed_blocks = DayNine::PartOne.compress_blocks(blocks)
    result = DayNine::PartOne.checksum(compressed_blocks)

    assert_equal(1928, result)
  end
end
