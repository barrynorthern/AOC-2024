# frozen_string_literal: true

class Vector2d
  def initialize(x, y)
    @x = x
    @y = y
  end

  def clone
    Vector2d.new(@x, @y)
  end

  def add(vector)
    Vector2d.new(@x + vector.x, @y + vector.y)
  end

  def subtract(vector)
    Vector2d.new(@x - vector.x, @y - vector.y)
  end

  def negate
    Vector2d.new(-@x, -@y)
  end

  def translate(vector)
    @x += vector.x
    @y += vector.y
  end

  def to_a
    [@y, @x]
  end

  def to_s
    "(#{@x}, #{@y})"
  end

  attr_reader :x, :y
end
