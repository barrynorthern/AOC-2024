# frozen_string_literal: true

require 'parslet'

class RentalTransform < Parslet::Transform
  rule(int: simple(:int)) { Integer(int) }

  rule(do: simple(:_)) { :do }
  rule(dont: simple(:_)) { :dont }
  rule(left: simple(:left), right: simple(:right)) { { type: :mul, left: left, right: right } }
end
