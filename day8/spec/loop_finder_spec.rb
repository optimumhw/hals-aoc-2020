# frozen_string_literal: true

require_relative '../loop_finder'

describe 'LoopFinder#last_acc_value' do
  context 'when given the sample input' do
    it 'detects lupe and returns the acc value' do
      expect(
        LoopFinder.last_acc_value('spec/sample.txt')
      ).to eq(5)
    end
  end

  context 'when given the puzzle input' do
    it 'detects lupe and returns the acc value' do
      expect(
        LoopFinder.last_acc_value('spec/puzzle_input.txt')
      ).to eq(1709)
    end
  end

  # part 2 ----------------------------

  context 'when given the sample input' do
    it 'fixes the lupe' do
      expect(
        LoopFinder.fix_loop('spec/sample.txt')
      ).to eq(8)
    end
  end

  context 'when given the puzzle input' do
    it 'fixes the lupe' do
      expect(
        LoopFinder.fix_loop('spec/puzzle_input.txt')
      ).to eq(1976)
    end
  end
end
