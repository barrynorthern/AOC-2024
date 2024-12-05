# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_two'
require_relative '../lib/part_one'

class DayFourPartTwoTest < Minitest::Test
  def data
    <<~DATA
      MMMSXXMASM
      MSAMXMSMSA
      AMXSXMAAMM
      MSAMASMSMX
      XMASAMXAMM
      XXAMMXXAMA
      SMSMSASXSS
      SAXAMASAAA
      MAMMMXMMMM
      MXMXAXMASX
    DATA
  end

  def xmas1data
    <<~DATA
      M.S
      .A.
      M.S
    DATA
  end

  def test_match_subset_in_matrix
    matrix = DayFour::PartOne.get_matrix_from_data(data)
    xmas1 = DayFour::PartOne.get_matrix_from_data(xmas1data)
    test_cases = {
      [xmas1, 0, 0] => false,
      [xmas1, 0, 1] => true
    }

    test_cases.each do |input, expected|
      result = DayFour::PartTwo.match_subset_in_matrix(matrix, input[0], input[1], input[2])

      assert_equal(expected, result)
    end
  end

  def test_run
    count = DayFour::PartTwo.run(data)

    assert_equal(9, count)
  end
end
