# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'

module DayThree
  module PartOne
    # Define the URL
    def self.url
      'https://adventofcode.com/2024/day/3/input'
    end

    def self.sum_valid_muls_from_data(data)
      regex = /mul\((\d+,\d+)\)/
      tuples = data.scan(regex).map { |match| match[0].split(',').map(&:to_i) }
      tuples.sum { |tuple| tuple[0] * tuple[1] }
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        input_data = Libs::Fetcher.fetch_data(url)
        sum = sum_valid_muls_from_data(input_data)
        puts "Sum of valid muls is: #{sum}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
  end
end
