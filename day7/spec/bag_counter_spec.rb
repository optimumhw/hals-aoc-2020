# frozen_string_literal: true

require_relative '../bag_counter'

describe 'BagCounter#count_bags' do

  context 'when given the small sample input' do
    it 'counts the bags' do
      expect(
        BagCounter.count_bags('spec/small_sample_input.txt')
      ).to eq(3)
    end
  end

  context 'when given the sample input' do
    it 'counts the bags' do
      expect(
        BagCounter.count_bags('spec/sample_input.txt')
      ).to eq(4)
    end
  end

  context 'when given the puzzle input' do
    it 'counts the bags' do
      expect(
        BagCounter.count_bags('spec/puzzle_input.txt')
      ).to eq(272)
    end
  end

  # part 2 tests........

  context 'when given the small sample input' do
    it 'counts the bags' do
      expect(
        BagCounter.count_gold_contents('spec/part2_very_small_sample.txt')
      ).to eq(30)
    end
  end

  context 'when given the small sample input' do
    it 'counts the bags' do
      expect(
        BagCounter.count_gold_contents('spec/sample_input.txt')
      ).to eq(32)
    end
  end

  context 'when given the larger sample input' do
    it 'counts the bags' do
      expect(
        BagCounter.count_gold_contents('spec/part2_larger_sample.txt')
      ).to eq(126)
    end
  end

  context 'when given the puzzle input' do
    it 'counts the bags' do
      expect(
        BagCounter.count_gold_contents('spec/puzzle_input.txt')
      ).to eq(172246)
    end
  end

end
