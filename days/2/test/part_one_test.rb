# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_one'

class DayTwoPartOneTest < Minitest::Test
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

  def test_get_reports_from_data
    reports = DayTwo::PartOne.get_reports_from_data(data)

    assert_equal([
                   [7, 6, 4, 2, 1],
                   [1, 2, 7, 8, 9],
                   [9, 7, 6, 2, 1],
                   [1, 3, 2, 4, 5],
                   [8, 6, 4, 4, 1],
                   [1, 3, 6, 7, 9]
                 ], reports)
  end

  def test_get_report_is_safe
    reports = DayTwo::PartOne.get_reports_from_data(data)
    results = [true, false, false, false, false, true]

    reports.each_with_index do |report, index|
      assert_equal(results[index], DayTwo::PartOne.get_report_is_safe(report), "Report #{report.inspect} failed")
    end
  end

  def test_can_return_the_correct_result
    result = DayTwo::PartOne.run(data)

    assert_equal(2, result)
  end
end
