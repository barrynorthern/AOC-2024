# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_two'

class DaySevenPartTwoTest < Minitest::Test
  def test_solve_equation
    test_cases = {
      [[6, 8, 6, 15], ['*', '||', '*']] => 7290,
      [[17, 8, 14], ['||', '+']] => 192
    }

    test_cases.each do |equations, expected|
      assert_equal(expected, DaySeven::PartOne.solve_equation(equations[0], equations[1]))
    end
  end

  def test_sum_of_valid_answers
    equations = DaySeven::PartOne.process_data(DaySevenPartOneTest.data)
    result = DaySeven::PartOne.sum_of_valid_answers(['+', '*', '||'], equations)

    assert_equal(11_387, result)
  end
end
