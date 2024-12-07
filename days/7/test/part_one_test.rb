# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_one'

class DaySevenPartOneTest < Minitest::Test
  def self.data
    <<~DATA
      190: 10 19
      3267: 81 40 27
      83: 17 5
      156: 15 6
      7290: 6 8 6 15
      161011: 16 10 13
      192: 17 8 14
      21037: 9 7 18 13
      292: 11 6 16 20
    DATA
  end

  def test_process_data
    equations = DaySeven::PartOne.process_data(DaySevenPartOneTest.data)

    assert_equal([
                   [190, [10, 19]],
                   [3267, [81, 40, 27]],
                   [83, [17, 5]],
                   [156, [15, 6]],
                   [7290, [6, 8, 6, 15]],
                   [161_011, [16, 10, 13]],
                   [192, [17, 8, 14]],
                   [21_037, [9, 7, 18, 13]],
                   [292, [11, 6, 16, 20]]
                 ],
                 equations)
  end

  def test_solve_equation
    test_cases = {
      [[19, 10], ['*']] => 190,
      [[19, 10, 45], ['*', '+']] => 235,
      [[19, 10, 45, 2], ['*', '+', '*']] => 470
    }

    test_cases.each do |equations, expected|
      assert_equal(expected, DaySeven::PartOne.solve_equation(equations[0], equations[1]))
    end
  end

  def test_sum_of_valid_answers
    equations = DaySeven::PartOne.process_data(DaySevenPartOneTest.data)
    result = DaySeven::PartOne.sum_of_valid_answers(['+', '*'], equations)

    assert_equal(3749, result)
  end
end
