require_relative '../tree_counter'

describe 'TreeCounter#count_trees' do
  context 'when given my sample' do
    it 'counts the number of trees' do
      expect(
        TreeCounter.count_trees('spec/sample_input.txt')
      ).to eq(1)
    end
  end

  context 'when given the aoc sample' do
    it 'counts the number of trees' do
      expect(
        TreeCounter.count_trees('spec/aoc_sample_input.txt')
      ).to eq(7)
    end
  end

  context 'when given the aoc sample' do
    it 'counts the number of trees' do
      expect(
        TreeCounter.count_trees('spec/puzzle_input.txt')
      ).to eq(169)
    end
  end
end
