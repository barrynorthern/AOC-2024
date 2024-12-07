# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'
require_relative 'guard'
require_relative 'map'

module DaySix
  module PartOne
    # Define the URL
    def self.url
      'https://adventofcode.com/2024/day/6/input'
    end

    def self.run(data)
      map = Map.new(data)
      guard = map.extract_guard
      map.traverse(guard)
      map.num_visited
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
