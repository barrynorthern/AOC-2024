# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'

module DayFive
  module PartOne
    # Define the URL
    def self.url
      'https://adventofcode.com/2024/day/5/input'
    end

    # Process data
    def self.process_data(data)
      rules = []
      updates = []
      sections = data.split("\n\n")
      sections[0].each_line do |line|
        rules << line.split('|').map(&:to_i)
      end
      sections[1].each_line do |line|
        updates << line.split(',').map(&:to_i).each_with_index.to_h
      end
      [rules, updates]
    end

    def self.update_valid?(rules, update)
      rules.each do |rule|
        left = update[rule[0]]
        right = update[rule[1]]
        return false unless left.nil? || right.nil? || left < right
      end
      true
    end

    def self.get_middle_value(update)
      update.keys[update.size >> 1]
    end

    def self.get_sum_of_valid_middle_updates(rules, updates)
      updates
        .filter { |update| update_valid?(rules, update) }
        .map { |update| get_middle_value(update) }
        .sum
    end

    def self.run(input_data)
      rules, updates = process_data(input_data)
      get_sum_of_valid_middle_updates(rules, updates)
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
