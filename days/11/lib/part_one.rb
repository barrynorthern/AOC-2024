# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'

module DayEleven
  module PartOne
    # Define the URL
    def self.url
      'https://adventofcode.com/2024/day/11/input'
    end

    # Process data
    def self.process_data(data)
      data.split.map(&:strip).map(&:to_i)
    end

    def self.num_digits(stone)
      Math.log10(stone).to_i + 1
    end

    def self.split_stone_in_half(stone)
      stone.divmod(10**(num_digits(stone) >> 1))
    end

    @memo = {}

    def self.modify_stone(stone)
      return @memo[stone] if @memo.key?(stone)

      result = if stone.zero?
                 [1]
               elsif num_digits(stone).even?
                 split_stone_in_half(stone)
               else
                 [stone * 2024]
               end
      @memo[stone] = result
      result
    end

    def self.run(stones, blinks)
      blinks.times do
        stones = stones.flat_map { |stone| modify_stone(stone) }
      end
      stones.length
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        input_data = Libs::Fetcher.fetch_data(url)
        stones = process_data(input_data)
        start_time = Time.now
        result = run(stones, 25)
        end_time = Time.now
        puts "Result: #{result}"
        puts "Execution Time: #{end_time - start_time} seconds"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
        puts e.backtrace.join("\n")
      end
    end
  end
end
