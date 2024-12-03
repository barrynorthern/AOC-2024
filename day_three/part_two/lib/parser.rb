# frozen_string_literal: true

require 'parslet'

class RentalParser < Parslet::Parser
  rule(:space)        { match('\s').repeat(1) }
  rule(:space?)       { space.maybe }
  rule(:digit)        { match('\d') }
  rule(:integer)      { digit.repeat(1).as(:int) }
  rule(:comma)        { str(',') }
  rule(:lparen)       { str('(') }
  rule(:rparen)       { str(')') }

  rule(:do_instruction)    { str('do()').as(:do) }
  rule(:dont_instruction)  { str("don't()").as(:dont) }
  rule(:mul_instruction)   { str('mul(') >> integer.as(:left) >> comma >> integer.as(:right) >> rparen }

  rule(:instruction) { do_instruction | dont_instruction | mul_instruction }
  rule(:expression)  { instruction.repeat }

  root(:expression)
end
