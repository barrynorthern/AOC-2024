# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require 'logger'
require_relative '../../../lib/fetch'
require_relative 'part_one'

module DayTwo
  module PartTwo
    # Get index with skip
    def self.skip_index(index, skip)
      return index if skip > index

      index + 1
    end

    # Check if the pair is safe (delta and direction)
    def self.get_pair_is_safe?(report, a_index, b_index, dir)
      a = report[a_index]
      b = report[b_index]
      delta = b - a
      delta.abs.between?(1, 3) && (delta <=> 0) == dir
    end

    # Get initial direction
    def self.initial_direction(report, skip)
      first_index = skip_index(0, skip)
      second_index = skip_index(1, skip)
      report[second_index] - report[first_index] <=> 0
    end

    # Get report is safe
    def self.get_report_is_safe_without_index(report, skip)
      return true if report.empty? || report.length <= 2

      dir = initial_direction(report, skip)

      (1...report.length - 1).each do |index|
        a_index = skip_index(index - 1, skip)
        b_index = skip_index(index, skip)
        return false unless get_pair_is_safe?(report, a_index, b_index, dir)
      end

      true
    end

    # Get report is safe
    def self.get_report_is_safe(report)
      return true if PartOne.get_report_is_safe(report)

      report.each_index.any? { |index| get_report_is_safe_without_index(report, index) }
    end

    def self.run(input_data)
      reports = PartOne.get_reports_from_data(input_data)
      reports.count { |report| get_report_is_safe(report) }
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        input_data = Libs::Fetcher.fetch_data(PartOne.url)
        num_safe_reports = run(input_data)
        puts "Number of safe reports: #{num_safe_reports}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
  end
end
