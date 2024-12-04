# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'
require_relative '../../part_one/lib/day_four_part_one'

module DayFour
  module PartTwo
    def self.match_subset_in_matrix(matrix, subset, row, column)
      ss_w = subset.length
      ss_h = subset[0].length
      matrix.length
      matrix[0].length

      0.upto(ss_h - 1) do |r|
        0.upto(ss_w - 1) do |c|
          subset_element = subset[r][c]

          next if subset_element == '.'

          return false if matrix[row + r][column + c] != subset_element
        end
      end
      true
    end

    def self.xmas1data
      <<~DATA
        M.S
        .A.
        M.S
      DATA
    end

    def self.xmas2data
      <<~DATA
        M.M
        .A.
        S.S
      DATA
    end

    def self.xmas3data
      <<~DATA
        S.S
        .A.
        M.M
      DATA
    end

    def self.xmas4data
      <<~DATA
        S.M
        .A.
        S.M
      DATA
    end

    def self.run(input_data)
      matrix = PartOne.get_matrix_from_data(input_data)
      count = 0
      # assuming these are all 3x3 subsets
      xmas1 = PartOne.get_matrix_from_data(xmas1data)
      xmas2 = PartOne.get_matrix_from_data(xmas2data)
      xmas3 = PartOne.get_matrix_from_data(xmas3data)
      xmas4 = PartOne.get_matrix_from_data(xmas4data)
      0.upto(PartOne.get_matrix_row_count(matrix) - 3) do |r|
        0.upto(PartOne.get_matrix_column_count(matrix) - 3) do |c|
          count += match_subset_in_matrix(matrix, xmas1, r, c) ? 1 : 0
          count += match_subset_in_matrix(matrix, xmas2, r, c) ? 1 : 0
          count += match_subset_in_matrix(matrix, xmas3, r, c) ? 1 : 0
          count += match_subset_in_matrix(matrix, xmas4, r, c) ? 1 : 0
        end
      end
      count
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        input_data = Libs::Fetcher.fetch_data(PartOne.url)
        count = run(input_data)
        puts "Number of X-MAS matches: #{count}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
  end
end
