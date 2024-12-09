# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'

module DayNine
  module PartOne
    # Define the URL
    def self.url
      'https://adventofcode.com/2024/day/9/input'
    end

    # Process data
    def self.load_diskmap(input)
      input.chars.map(&:to_i)
    end

    def self.expand_blocks(disk_map)
      disk_map.each_slice(2)
              .map.with_index { |(a, b), index| [a, b, index] }
              .reduce([]) do |acc, (file_len, free_len, file_id)|
        acc.concat(file_len ? Array.new(file_len, file_id) : []).concat(free_len ? Array.new(free_len, -1) : [])
      end
    end

    def self.compress_blocks(blocks)
      i = 0 # Forward pointer
      j = blocks.length - 1 # Backward pointer

      while i < j
        if blocks[i] == -1
          # Move backward pointer until we find a number
          j -= 1 while i < j && blocks[j] == -1

          # Swap characters if valid
          blocks[i], blocks[j] = blocks[j], blocks[i] if i < j
        end
        # Move forward pointer
        i += 1
      end

      blocks
    end

    def self.checksum(compressed_blocks)
      compressed_blocks
        .reject { |block| block == -1 }
        .each_with_index
        .reduce(0) { |acc, (block, index)| acc + (block * index) }
    end

    def self.run(input)
      disk_map = load_diskmap(input)
      blocks = expand_blocks(disk_map)
      compressed_blocks = compress_blocks(blocks)
      checksum(compressed_blocks)
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
