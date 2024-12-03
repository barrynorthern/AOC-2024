# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'

module DayTwo
  module PartOne
    # Define the URL
    def self.url
      'https://adventofcode.com/2024/day/2/input'
    end

    # Get reports from the data
    def self.get_reports_from_data(data)
      reports = []

      data.each_line do |line|
        # Split the line into a number array by spaces
        numbers = line.strip.split.map(&:to_i)
        # Add the numbers to the respective lists
        reports << numbers if numbers
      end

      reports
    end

    # Get report is safe
    def self.get_report_is_safe(report)
      # Rules: (safe iff)
      # ascending order OR descending order AND
      # delta between each number is between 1 and 3 inclusive
      # return true if safe, false otherwise
      return true if report.empty? || report.length == 1

      dir = report[1] - report[0] <=> 0
      report.each_cons(2).all? do |a, b|
        delta = b - a
        delta.abs.between?(1, 3) && (delta <=> 0) == dir
      end
    end

    def self.run(input_data)
      reports = get_reports_from_data(input_data)
      reports.count { |report| get_report_is_safe(report) }
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        input_data = Libs::Fetcher.fetch_data(url)
        num_safe_reports = run(input_data)
        puts "Number of safe reports: #{num_safe_reports}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
  end
end
