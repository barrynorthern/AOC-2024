# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'
require_relative '../../part_one/lib/day_one_part_one'

module DayOne
  module PartTwo
    # Get the similarity between the lists
    def self.get_similarity_between_lists(list_left, list_right)
      list_left.sum do |number|
        frequency = list_right.count(number)
        number * frequency
      end
    end

    def self.run(input_data)
      list_left, list_right = PartOne.get_lists_from_data(input_data)
      get_similarity_between_lists(list_left, list_right)
    end

    # Run the program and output the result

    if __FILE__ == $PROGRAM_NAME
      begin
        input_data = Libs::Fetcher.fetch_data(PartOne.url)
        similarity = run(input_data)
        puts "Similarity between lists: #{similarity}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
  end
end
