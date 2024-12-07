# frozen_string_literal: true

require_relative '../../../lib/vector2d'

module DaySix
  class Guard
    class Meta
      def initialize(x, y, turn, mask)
        @dir = Vector2d.new(x, y)
        @turn = turn
        @mask = mask
      end

      attr_reader :dir, :turn, :mask
    end

    META = {
      '^' => Meta.new(0, -1, '>', 0b0001),
      '<' => Meta.new(-1, 0, '^', 0b0010),
      '>' => Meta.new(1,  0, 'v', 0b0100),
      'v' => Meta.new(0,  1, '<', 0b1000)
    }.freeze

    def initialize(position, char)
      @position = position
      @char = char
    end

    attr_reader :position, :char

    def x
      @position.x
    end

    def y
      @position.y
    end

    def direction
      META[@char].dir
    end

    def mask
      META[@char].mask
    end

    def turn
      @char = META[@char].turn
    end

    def move
      @position.translate(direction)
    end

    def next?
      @position.add(direction)
    end

    def self.guard?(char)
      META.keys.include?(char)
    end
  end
end
