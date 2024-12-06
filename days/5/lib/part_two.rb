# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'
require_relative 'part_one'

module DayFive
  module PartTwo
    def self.order_update(rules, update)
      hash = update.clone
      rules.each do |rule|
        left = hash[rule[0]]
        right = hash[rule[1]]
        next if left.nil? || right.nil? || left < right

        array = hash.keys
        right_value = array.delete_at(right)
        array.insert(left, right_value)
        hash = array.each_with_index.to_h
      end
      hash
    end

    def self.order_update_until_valid(rules, update)
      ordered = update.clone
      attempts = 0 # safety net
      while !PartOne.update_valid?(rules, ordered) && attempts < 100
        ordered = order_update(rules, ordered)
        attempts += 1
      end
      ordered
    end

    def self.get_sum_of_invalid_ordered_middle_updates(rules, updates)
      updates
        .reject { |update| PartOne.update_valid?(rules, update) }
        .map { |update| PartOne.get_middle_value(order_update_until_valid(rules, update)) }
        .sum
    end

    def self.run(input_data)
      rules, updates = PartOne.process_data(input_data)
      get_sum_of_invalid_ordered_middle_updates(rules, updates)
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
