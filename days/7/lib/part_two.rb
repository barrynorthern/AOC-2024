# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'
require_relative 'part_one'

module DaySeven
  module PartTwo
    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        data = Libs::Fetcher.fetch_data(PartOne.url)
        result = PartOne.sum_of_valid_answers(['+', '*', '||'], PartOne.process_data(data))
        puts "Result: #{result}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
  end
end
