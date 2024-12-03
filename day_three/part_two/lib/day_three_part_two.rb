# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require_relative '../../../lib/fetch'
require_relative '../../part_one/lib/day_three_part_one'
require_relative 'preprocessor'
require_relative 'parser'
require_relative 'transform'
require_relative 'evaluator'

module DayThree
  module PartTwo
    def self.run(data)
      parser = RentalParser.new
      transform = RentalTransform.new
      evaluator = RentalEvaluator.new
      processed = RentalPreprocessor.preprocess(data)
      parsed = parser.parse(processed)
      transformed = transform.apply(parsed)
      evaluator.evaluate(transformed)
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        input_data = Libs::Fetcher.fetch_data(PartOne.url)
        sum = run(input_data)
        puts "Result of program is: #{sum}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
  end
end
