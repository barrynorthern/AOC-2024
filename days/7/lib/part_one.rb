# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'

module DaySeven
  module PartOne
    # Define the URL
    def self.url
      'https://adventofcode.com/2024/day/7/input'
    end

    # Process data
    def self.process_data(data)
      equations = []
      data.each_line do |line|
        answer, operands = line.split(':')
        equations << [answer.to_i, operands.split.map(&:strip).map(&:to_i)]
      end
      equations
    end

    def self.solve_equation(operands, operators)
      answer = operands[0]
      (1...operands.size).each do |i|
        case operators[i - 1]
        when '||'
          answer = (answer.to_s + operands[i].to_s).to_i
        when '+'
          answer += operands[i]
        when '*'
          answer *= operands[i]
        end
      end
      answer
    end

    def self.match_equation(operators, operands, answer)
      operators.repeated_permutation(operands.size - 1).any? do |operator_permutation|
        answer == solve_equation(operands, operator_permutation)
      end
    end

    def self.sum_of_valid_answers(operators, equations)
      equations.reduce(0) { |acc, eq| match_equation(operators, eq[1], eq[0]) ? acc + eq[0] : acc }
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        data = Libs::Fetcher.fetch_data(url)
        result = sum_of_valid_answers(['+', '*'], process_data(data))
        puts "Result: #{result}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
  end
end
