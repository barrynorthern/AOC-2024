# frozen_string_literal: true

class RentalPreprocessor
  def self.preprocess(input)
    input.scan(/do\(\)|don't\(\)|mul\(\d+,\d+\)/).join
  end
end
