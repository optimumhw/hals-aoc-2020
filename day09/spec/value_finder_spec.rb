# frozen_string_literal: true

require_relative '../value_finder'

describe 'ValueFinder#find_bad_value' do
  context 'when given the sample input and preamble length' do
    it 'returns the bad value' do
      expect(
        ValueFinder.find_bad_value('spec/sample.txt', 5)
      ).to eq(127)
    end
  end

  context 'when given the puzzle input and preamble length' do
    it 'returns the bad value' do
      expect(
        ValueFinder.find_bad_value('spec/puzzle_input.txt', 25)
      ).to eq(1_124_361_034)
    end
  end

  # part 2 ------------------------------------
  context 'when given the sample input and preamble length' do
    it 'returns the weakness' do
      expect(
        ValueFinder.find_weakness('spec/sample.txt', 5)
      ).to eq(62)
    end
  end

  context 'when given the puzzle input and preamble length' do
    it 'returns the weakness' do
      expect(
        ValueFinder.find_weakness('spec/puzzle_input.txt', 25)
      ).to eq(129_444_555)
    end
  end
end
