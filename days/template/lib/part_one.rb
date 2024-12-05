# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'

module DayTemplate
  module PartOne
    # Define the URL
    def self.url
      'https://adventofcode.com/2024/day/1/input'
    end

    # Process data
    def self.process_data(data)
      data.each_line do |line|
        puts line
      end
    end

    def self.run(_input_data)
      0
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        input_data = Libs::Fetcher.fetch_data(url)
        result = run(input_data)
        puts "Result: #{result}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
  end
end
