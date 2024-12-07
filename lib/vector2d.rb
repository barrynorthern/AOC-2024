# frozen_string_literal: true

class Vector2d
  def initialize(x, y)
    @x = x
    @y = y
  end

  def add(vector)
    Vector2d.new(@x + vector.x, @y + vector.y)
  end

  def translate(vector)
    @x += vector.x
    @y += vector.y
  end

  attr_reader :x, :y
end
