# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'
require_relative 'part_one'

module DayNine
  module PartTwo
    def self.run_length_encode(blocks)
      encoded = []
      count = 0
      prev = blocks[0]
      blocks.each do |block|
        if block == prev
          count += 1
        else
          encoded << [count, prev]
          count = 1
          prev = block
        end
      end
      encoded << [count, prev]
      encoded
    end

    # rubocop:disable Metrics/CyclomaticComplexity
    def self.compress_files(blocks)
      i = 0 # Forward pointer
      j = blocks.length - 1 # Backward pointer

      is_space = ->((_, value)) { value == -1 }
      is_valid_swap = lambda { |(space, value), (file_size, _)|
        value == -1 && space >= file_size
      }
      #   debug = lambda {
      #     puts(blocks.map do |(count, value)|
      #       (value == -1 ? '.' : value.to_s) * count
      #     end.join)
      #   }

      #   debug.call

      while j.positive?
        # Move backward pointer until we find a valid block
        j -= 1 while is_space.call(blocks[j])

        i = 0
        while i < j
          # Swap and adjust space if valid
          if i < j && is_valid_swap.call(blocks[i], blocks[j])
            blocks[i], blocks[j] = blocks[j], blocks[i]
            # calculate remaining space in moved space block
            rem = blocks[j][0] - blocks[i][0]
            # if there is remaining space
            # rubocop:disable Metrics/BlockNesting
            if rem.positive?
              # reduce the space in the moved space block
              blocks[j][0] -= rem
              # insert a new space block after the moved file block
              blocks.insert(i + 1, [rem, -1])
              # increment the backward pointer
              j += 1
            end
            # ensure we scan for space again from the start
            # debug.call
            # rubocop:enable Metrics/BlockNesting
            break
          end
          # Move forward pointer
          i += 1
        end
        j -= 1
      end

      blocks
    end

    # rubocop:enable Metrics/CyclomaticComplexity

    def self.checksum(compressed_files)
      compressed_files
        .map { |(count, value)| Array.new(count, value) }
        .flatten
        .each_with_index
        .reduce(0) { |acc, (block, index)| acc + (block.positive? ? (block * index) : 0) }
    end

    def self.run(input)
      disk_map = PartOne.load_diskmap(input)
      blocks = PartOne.expand_blocks(disk_map)
      encoded = run_length_encode(blocks)
      compressed_files = compress_files(encoded)
      checksum(compressed_files)
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
