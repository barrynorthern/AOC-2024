# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'dotenv/load'
require 'set'
require_relative '../../../lib/vector2d'
require_relative '../../../lib/fetch'

module DayEight
  module PartOne
    # Define the URL
    def self.url
      'https://adventofcode.com/2024/day/8/input'
    end

    class Map
      def initialize(data)
        lines = data.split("\n").map(&:strip).map(&:chars)
        @height = lines.length
        @width = lines[0].length
        @nodes = Hash.new { |hash, key| hash[key] = [] }

        (0..@height - 1).each do |y|
          (0..@width - 1).each do |x|
            char = lines[y][x]
            next if char == '.'

            @nodes[char] << to_index(Vector2d.new(x, y))
          end
        end
      end

      attr_reader :nodes

      def to_index(vector)
        (vector.y * @width) + vector.x
      end

      def to_coord(index)
        y, x = index.divmod(@width)
        Vector2d.new(x, y)
      end

      def out_of_bounds?(vector)
        vector.x.negative? || vector.x >= @width || vector.y.negative? || vector.y >= @height
      end

      def add_non_resonant_antinodes(p0, p1)
        delta = p1.subtract(p0)
        p0 = p0.subtract(delta)
        p1 = p1.add(delta)
        @antinodes << to_index(p0) unless out_of_bounds?(p0)
        @antinodes << to_index(p1) unless out_of_bounds?(p1)
      end

      def add_resonant_antinodes(p0, p1)
        add_antinodes = lambda do |point, delta|
          loop do
            point = point.add(delta)
            break if out_of_bounds?(point)

            @antinodes << to_index(point)
          end
        end

        add_antinodes.call(p0, p1.subtract(p0))
        add_antinodes.call(p1, p0.subtract(p1))
      end

      def find_antinodes(resonant: false)
        @antinodes = Set.new

        @nodes.each_value do |value|
          value.combination(2).each do |pair|
            p0 = to_coord(pair[0])
            p1 = to_coord(pair[1])
            p0, p1 = p1, p0 if p0.x > p1.x
            if resonant
              add_resonant_antinodes(p0, p1)
            else
              add_non_resonant_antinodes(p0, p1)
            end
          end
        end
        @antinodes
      end
    end

    # Process data
    def self.process_data(data)
      Map.new(data)
    end

    def self.run(map)
      map.find_antinodes.length
    end

    # Run the program and output the result
    if __FILE__ == $PROGRAM_NAME
      begin
        input_data = Libs::Fetcher.fetch_data(url)
        map = process_data(input_data)
        result = run(map)
        puts "Result: #{result}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
  end
end
