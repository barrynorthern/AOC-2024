# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../lib/part_one'

class DayFivePartOneTest < Minitest::Test
  def data
    <<~DATA
      47|53
      97|13
      97|61
      97|47
      75|29
      61|13
      75|53
      29|13
      97|29
      53|29
      61|53
      97|53
      61|29
      47|13
      75|47
      97|75
      47|61
      75|61
      47|29
      75|13
      53|13

      75,47,61,53,29
      97,61,53,29,13
      75,29,13
      75,97,47,61,53
      61,13,29
      97,13,75,29,47
    DATA
  end

  def test_process_data
    rules, updates = DayFive::PartOne.process_data(data)

    assert_equal([
                   [47, 53],
                   [97, 13],
                   [97, 61],
                   [97, 47],
                   [75, 29],
                   [61, 13],
                   [75, 53],
                   [29, 13],
                   [97, 29],
                   [53, 29],
                   [61, 53],
                   [97, 53],
                   [61, 29],
                   [47, 13],
                   [75, 47],
                   [97, 75],
                   [47, 61],
                   [75, 61],
                   [47, 29],
                   [75, 13],
                   [53, 13]
                 ], rules)

    assert_equal([
                   { 75 => 0, 47 => 1, 61 => 2, 53 => 3, 29 => 4 },
                   { 97 => 0, 61 => 1, 53 => 2, 29 => 3, 13 => 4 },
                   { 75 => 0, 29 => 1, 13 => 2 },
                   { 75 => 0, 97 => 1, 47 => 2, 61 => 3, 53 => 4 },
                   { 61 => 0, 13 => 1, 29 => 2 },
                   { 97 => 0, 13 => 1, 75 => 2, 29 => 3, 47 => 4 }
                 ], updates)
  end

  def test_update_valid?
    rules, updates = DayFive::PartOne.process_data(data)
    test_cases = {
      updates[0] => true,
      updates[1] => true,
      updates[2] => true,
      updates[3] => false,
      updates[4] => false,
      updates[5] => false
    }
    test_cases.each do |input, expected|
      result = DayFive::PartOne.update_valid?(rules, input)

      assert_equal(expected, result)
    end
  end

  def test_get_middle_value
    _, updates = DayFive::PartOne.process_data(data)
    test_cases = {
      updates[0] => 61,
      updates[1] => 53,
      updates[2] => 29,
      updates[3] => 47,
      updates[4] => 13,
      updates[5] => 75
    }
    test_cases.each do |input, expected|
      result = DayFive::PartOne.get_middle_value(input)

      assert_equal(expected, result)
    end
  end

  def test_get_sum_of_valid_middle_updates
    rules, updates = DayFive::PartOne.process_data(data)
    result = DayFive::PartOne.get_sum_of_valid_middle_updates(rules, updates)

    assert_equal(143, result)
  end
end
