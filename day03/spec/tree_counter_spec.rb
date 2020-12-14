require_relative '../tree_counter'

describe 'TreeCounter#count_trees' do
  context 'when given my sample' do
    it 'counts the number of trees' do
      expect(
        TreeCounter.count_trees('spec/sample_input.txt', [[3, 1]])
      ).to eq(1)
    end
  end

  context 'when given the aoc sample' do
    it 'counts the number of trees' do
      expect(
        TreeCounter.count_trees('spec/aoc_sample_input.txt', [[3, 1]])
      ).to eq(7)
    end
  end

  context 'when given my part 1 input' do
    it 'counts the number of trees' do
      expect(
        TreeCounter.count_trees('spec/puzzle_input.txt', [[3, 1]])
      ).to eq(169)
    end
  end

  # part 2

  context 'when given the aoc sample and the array of slopes' do
    it 'returns the product of the counts' do
      expect(
        TreeCounter.count_trees('spec/aoc_sample_input.txt', [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]])
      ).to eq(336)
    end
  end

  context 'when given my part2 input and the array of slopes' do
    it 'returns the product of the counts' do
      expect(
        TreeCounter.count_trees('spec/puzzle_input.txt', [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]])
      ).to eq(7_560_370_818)
    end
  end
end
