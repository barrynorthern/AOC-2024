# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'

module DayOne
  module PartOne
    # Define the URL
    def self.url
      'https://adventofcode.com/2024/day/1/input'
    end

    # Get lists from the data
    def self.get_lists_from_data(data)
      list_left = []
      list_right = []

      data.each_line do |line|
        # Split the line by three spaces
        numbers = line.strip.split('   ')
        # Add the numbers to the respective lists
        list_left << numbers[0].to_i if numbers[0]
        list_right << numbers[1].to_i if numbers[1]
      end

      [list_left, list_right]
    end

    # Get the total distance between the lists
    def self.get_total_distance_between_lists(list_left, list_right)
      list_left.sort.zip(list_right.sort).sum { |left, right| (left - right).abs }
    end

    def self.run(input_data)
      list_left, list_right = get_lists_from_data(input_data)
      get_total_distance_between_lists(list_left, list_right)
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        input_data = Libs::Fetcher.fetch_data(url)
        total_distance = run(input_data)
        puts "Distance between lists: #{total_distance}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
  end
end
