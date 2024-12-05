# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_one'
require_relative '../lib/part_two'

class DayTwoPartTwoTest < Minitest::Test
  def data
    <<~DATA
      7 6 4 2 1
      1 2 7 8 9
      9 7 6 2 1
      1 3 2 4 5
      8 6 4 4 1
      1 3 6 7 9
    DATA
  end

  def test_skip_index
    [0, 2, 3, 4, 5].each_with_index do |expected, index|
      assert_equal(expected, DayTwo::PartTwo.skip_index(index, 1))
    end
  end

  def test_get_report_is_safe_without_index
    report = [1, 3, 2, 4, 5]

    assert(DayTwo::PartTwo.get_report_is_safe_without_index(report, 1))
  end

  #   def test_get_report_is_safe
  #     reports = DayTwo::PartOne.get_reports_from_data(data)
  #     results = [true, false, false, true, true, true]

  #     reports.each_with_index do |report, index|
  #       assert_equal(results[index], DayTwo::PartTwo.get_report_is_safe(report), "Report #{report.inspect} failed")
  #     end
  #   end

  #   def test_can_return_the_correct_result
  #     result = DayTwo::PartTwo.run(data)

  #     assert_equal(4, result)
  #   end
end
