# frozen_string_literal: true

require_relative '../../../lib/vector2d'
require_relative 'guard'

module DaySix
  class Map
    def initialize(data)
      @grid = []
      data.each_line do |line|
        @grid << line.strip.chars
      end
    end

    def extract_guard
      @grid.each_with_index do |line, y|
        x = line.find_index { |char| Guard.guard?(char) }
        next if x.nil?

        guard = Guard.new(Vector2d.new(x, y), @grid[y][x])
        clear_position(guard.position)
        return guard
      end
      nil
    end

    def width
      @grid[0].size
    end

    def height
      @grid.size
    end

    def traverse(guard)
      @visits = Array.new(height) { Array.new(width) { 0 } }
      # loop while guard is in grid and hasn't already travelled across
      # a given point in the same direction because this would means she's
      # stuck in a loop, and she won't go anywhere new, so we're done.
      advance(guard) while inside?(guard.position) && !visited_facing?(guard)
    end

    def num_visited
      @visits.flatten.count(&:positive?)
    end

    def add_obstacle(position)
      return false if obstacle?(position)
      return false unless inside?(position)

      @grid[position.y][position.x] = '#'
    end

    def clear_position(position)
      @grid[position.y][position.x] = '.'
    end

    def inside?(position)
      position.x >= 0 && position.y >= 0 && position.y < height && position.x < width
    end

    private

    def obstacle?(position)
      inside?(position) && @grid[position.y][position.x] == '#'
    end

    def visited_facing?(guard)
      @visits[guard.y][guard.x].anybits?(guard.mask)
    end

    def advance(guard)
      # guard.mask is a bit mask that represents the direction the guard is facing
      # and we want to know what that is later after she's turned
      mask = guard.mask
      # worst case she will come out the way she came in,
      # so she can't be stuck in an infinite loop
      guard.turn while obstacle?(guard.next?)
      # mark the position she's at as visited in the direction she *was* facing
      visit(guard.position, mask)
      # move to the next position
      guard.move
    end

    def visit(position, mask)
      @visits[position.y][position.x] |= mask
    end
  end
end
