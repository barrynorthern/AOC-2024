# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'
require_relative 'part_one'

module DayEleven
  module PartTwo
    def self.convert_to_hash(array)
      array.each_with_object(Hash.new(0)) do |value, hash|
        hash[value] += 1
      end
    end

    def self.blink(master)
      master.clone.each do |stone, count|
        next if count.zero?

        master[stone] -= count
        if stone.zero?
          master[1] += count
        elsif PartOne.num_digits(stone).even?
          left, right = PartOne.split_stone_in_half(stone)
          master[left] += count
          master[right] += count
        else
          master[stone * 2024] += count
        end
      end
    end

    def self.run(stones, blinks)
      master = convert_to_hash(stones)
      blinks.times do
        blink(master)
      end
      master.values.sum
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        puts "Fetching data from URL: #{PartOne.url}"
        input_data = Libs::Fetcher.fetch_data(PartOne.url)
        stones = PartOne.process_data(input_data)
        start_time = Time.now
        result = run(stones, 75)
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
