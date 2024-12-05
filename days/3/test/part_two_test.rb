# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_one'
require_relative '../lib/part_two'

class DayThreePartTwoTest < Minitest::Test
  def program1
    <<~DATA
      xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
    DATA
  end

  def program2
    <<~DATA
      mul(2,4)don't()mul(20,4)do()mul(3,3)don't()mul(5,2)do()mul(4,3)don't()mul(2,4)
    DATA
  end

  def test_run_program1
    result = DayThree::PartTwo.run(program1)

    assert_equal(48, result, 'Program 1 failed')
  end

  def test_run_program2
    result = DayThree::PartTwo.run(program2)

    assert_equal(29, result, 'Program 2 failed')
  end
end
