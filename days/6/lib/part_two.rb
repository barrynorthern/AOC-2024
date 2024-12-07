# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'
require_relative 'part_one'
require_relative 'guard'
require_relative 'map'

module DaySix
  module PartTwo
    def self.run(data)
      map = Map.new(data)
      guard = map.extract_guard
      count = 0
      (0..map.height - 1).each do |y|
        (0..map.width - 1).each do |x|
          position = Vector2d.new(x, y)
          next unless map.add_obstacle(position)

          clone = guard.clone
          map.traverse(clone)
          count += 1 if map.inside?(clone.position)
          map.clear_position(position)
        end
      end
      count
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        input_data = Libs::Fetcher.fetch_data(PartOne.url)
        result = run(input_data)
        puts "Result: #{result}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
  end
end
