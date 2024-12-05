# frozen_string_literal: true

class RentalEvaluator
  def initialize
    @enabled = true
  end

  def evaluate(instructions)
    sum = 0

    instructions.each do |instruction|
      sum += process_instruction(instruction)
    end

    sum
  end

  private

  def process_instruction(instruction)
    case instruction
    when :do
      handle_do
    when :dont
      handle_dont
    when Hash
      handle_mul(instruction)
    else
      0
    end
  end

  def handle_do
    enable_mul
    0
  end

  def handle_dont
    disable_mul
    0
  end

  def handle_mul(instruction)
    return 0 unless instruction[:type] == :mul && @enabled

    instruction[:left] * instruction[:right]
  end

  def enable_mul
    @enabled = true
  end

  def disable_mul
    @enabled = false
  end
end
