# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_one'

class DayFourPartOneTest < Minitest::Test
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

  def test_get_matrix_from_data
    matrix = DayFour::PartOne.get_matrix_from_data(data)

    assert_equal([
                   %w[M M M S X X M A S M],
                   %w[M S A M X M S M S A],
                   %w[A M X S X M A A M M],
                   %w[M S A M A S M S M X],
                   %w[X M A S A M X A M M],
                   %w[X X A M M X X A M A],
                   %w[S M S M S A S X S S],
                   %w[S A X A M A S A A A],
                   %w[M A M M M X M M M M],
                   %w[M X M X A X M A S X]
                 ], matrix)
  end

  def test_get_string_from_matrix_row_row
    matrix = DayFour::PartOne.get_matrix_from_data(data)
    result = DayFour::PartOne.get_string_from_matrix(matrix, 0, 'row')

    assert_equal('MMMSXXMASM', result)
    result = DayFour::PartOne.get_string_from_matrix(matrix, 3, 'row')

    assert_equal('MSAMASMSMX', result)
  end

  def test_get_string_from_matrix_row_column
    matrix = DayFour::PartOne.get_matrix_from_data(data)

    result = DayFour::PartOne.get_string_from_matrix(matrix, 0, 'column')

    assert_equal('MMAMXXSSMM', result)
    result = DayFour::PartOne.get_string_from_matrix(matrix, 9, 'column')

    assert_equal('MAMXMASAMX', result)
  end

  def test_get_string_from_matrix_row_diagonal
    matrix = DayFour::PartOne.get_matrix_from_data(data)

    test_cases = {
      ['l_diag', 0] => 'M',
      ['l_diag', 1] => 'MM',
      ['l_diag', 2] => 'ASM',
      ['l_diag', 9] => 'MAXMMMMASM',
      ['l_diag', 10] => 'XMASXXSMA',
      ['l_diag', 15] => 'MMAS',

      ['r_diag', 0] => 'M',
      ['r_diag', 1] => 'SA',
      ['r_diag', 2] => 'ASM',
      ['r_diag', 9] => 'MSXMAXSAMX',
      ['r_diag', 10] => 'MMASMASMS',
      ['r_diag', 15] => 'SAMX'

    }

    test_cases.each do |input, expected|
      result = DayFour::PartOne.get_string_from_matrix(matrix, input[1], input[0])

      assert_equal(expected, result)
    end
  end

  def test_count_strings_in_matrix
    matrix = DayFour::PartOne.get_matrix_from_data(data)
    result = DayFour::PartOne.count_strings_in_matrix('XMAS', matrix)

    assert_equal(18, result)
  end
end
