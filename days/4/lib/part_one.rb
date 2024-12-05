# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'

module DayFour
  module PartOne
    # Define the URL
    def self.url
      'https://adventofcode.com/2024/day/4/input'
    end

    # Get matrix from the data
    def self.get_matrix_from_data(data)
      matrix = []

      data.each_line do |line|
        # split the line into characters
        characters = line.strip.chars
        # Add the characters to the matrix
        matrix << characters if characters
      end

      matrix
    end

    # Get the number of rows in the matrix
    def self.get_matrix_row_count(matrix)
      matrix.length
    end

    # Get the number of columns in the matrix
    def self.get_matrix_column_count(matrix)
      matrix[0].length
    end

    # Get the number of diagonals in the matrix
    def self.get_matrix_diagonal_count(matrix)
      get_matrix_row_count(matrix) + get_matrix_column_count(matrix) - 1
    end

    # Get the string from the matrix
    def self.get_string_from_matrix(matrix, index, direction)
      case direction
      when 'row'
        get_string_from_matrix_row(matrix, index)
      when 'column'
        get_string_from_matrix_column(matrix, index)
      when 'l_diag'
        get_string_from_matrix_l_diagonal(matrix, index)
      when 'r_diag'
        get_string_from_matrix_r_diagonal(matrix, index)
      else
        raise ArgumentError, "Invalid direction: #{direction}"
      end
    end

    # Get a row from the matrix
    def self.get_string_from_matrix_row(matrix, index)
      return '' if index >= get_matrix_row_count(matrix)

      matrix[index].join
    end

    # Get a column from the matrix
    def self.get_string_from_matrix_column(matrix, index)
      return '' if index >= get_matrix_column_count(matrix)

      matrix.map { |row| row[index] }.join
    end

    # Get a left diagonal from the matrix
    def self.get_string_from_matrix_l_diagonal(matrix, index)
      return '' if index >= get_matrix_diagonal_count(matrix)

      num_rows = get_matrix_row_count(matrix)
      num_cols = get_matrix_column_count(matrix)
      diagonal = []
      row = index < num_rows ? index : num_rows - 1
      column = index < num_rows ? 0 : index - num_rows + 1
      while row >= 0 && column < num_cols
        diagonal << matrix[row][column]
        row -= 1
        column += 1
      end
      diagonal.join
    end

    # Get a right diagonal from the matrix
    def self.get_string_from_matrix_r_diagonal(matrix, index)
      return '' if index >= get_matrix_diagonal_count(matrix)

      num_rows = get_matrix_row_count(matrix)
      num_cols = get_matrix_column_count(matrix)
      diagonal = []
      row = index < num_cols ? 0 : index - num_cols + 1
      column = index < num_cols ? num_cols - index - 1 : 0
      while column < num_cols && row < num_rows
        diagonal << matrix[row][column]
        row += 1
        column += 1
      end
      diagonal.join
    end

    def self.count_strings_in_matrix(match, matrix)
      count = 0
      count += count_strings_in_matrix_rows(match, matrix)
      count += count_strings_in_matrix_columns(match, matrix)
      count += count_strings_in_matrix_l_diagonals(match, matrix)
      count += count_strings_in_matrix_r_diagonals(match, matrix)
      count
    end

    def self.count_strings_in_matrix_rows(match, matrix)
      count = 0
      r_match = match.reverse
      num_rows = get_matrix_row_count(matrix)
      0.upto(num_rows).each do |i|
        row = get_string_from_matrix_row(matrix, i)
        count += row.scan(match).length
        count += row.scan(r_match).length
      end
      count
    end

    def self.count_strings_in_matrix_columns(match, matrix)
      count = 0
      r_match = match.reverse
      num_cols = get_matrix_column_count(matrix)
      0.upto(num_cols).each do |i|
        column = get_string_from_matrix_column(matrix, i)
        count += column.scan(match).length
        count += column.scan(r_match).length
      end
      count
    end

    def self.count_strings_in_matrix_r_diagonals(match, matrix)
      count = 0
      r_match = match.reverse
      num_diag = get_matrix_diagonal_count(matrix)
      0.upto(num_diag).each do |i|
        r_diag = get_string_from_matrix_r_diagonal(matrix, i)
        count += r_diag.scan(match).length
        count += r_diag.scan(r_match).length
      end
      count
    end

    def self.count_strings_in_matrix_l_diagonals(match, matrix)
      count = 0
      r_match = match.reverse
      num_diag = get_matrix_diagonal_count(matrix)
      0.upto(num_diag).each do |i|
        l_diag = get_string_from_matrix_l_diagonal(matrix, i)
        count += l_diag.scan(match).length
        count += l_diag.scan(r_match).length
      end
      count
    end

    def self.run(input_data)
      matrix = get_matrix_from_data(input_data)
      count_strings_in_matrix('XMAS', matrix)
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        input_data = Libs::Fetcher.fetch_data(url)
        count = run(input_data)
        puts "Number of XMAS matches: #{count}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
  end
end
