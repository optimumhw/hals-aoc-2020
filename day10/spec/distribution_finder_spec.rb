# frozen_string_literal: true

require_relative '../distribution_finder'

describe 'DistributionFinder#find_answer' do
  context 'when given the sample input' do
    it 'computes the answer' do
      expect(
        DistributionFinder.find_answer('spec/sample.txt')
      ).to eq(220)
    end
  end

  context 'when given the puzzle input' do
    it 'computes the answer' do
      expect(
        DistributionFinder.find_answer('spec/puzzle_input.txt')
      ).to eq(2201)
    end
  end

  # part 2 --------------------------------

  context 'when given a small array of values' do
    it 'counts the distribuions' do
      expect(
        DistributionFinder.quick_count_values([2, 3, 4, 5, 6, 7])
      ).to eq(20)
    end
  end

  context 'when given the larger sample input' do
    it 'counts the distribuions' do
      expect(
        DistributionFinder.quick_count('spec/part2_larger_sample.txt')
      ).to eq(19_208)
    end
  end

  context 'when given the puzzle input' do
    it 'counts the distribuions' do
      expect(
        DistributionFinder.quick_count('spec/puzzle_input.txt')
      ).to eq(169_255_295_254_528)
    end
  end
end
