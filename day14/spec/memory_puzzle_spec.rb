# frozen_string_literal: true

require_relative '../memory_puzzle'

describe 'MemoryPuzzle#mem_sum' do
  context 'when given the sample' do
    it 'computes the sum' do
      expect(
        MemoryPuzzle.mem_sum('spec/sample_input.txt')
      ).to eq(165)
    end
  end

  context 'when given the sample' do
    it 'computes the sum' do
      expect(
        MemoryPuzzle.mem_sum('spec/other_sample.txt')
      ).to eq(213_986_804_508)
    end
  end

  context 'when given the puzzle input' do
    it 'computes the sum' do
      expect(
        MemoryPuzzle.mem_sum('spec/puzzle_input.txt')
      ).to eq(10_035_335_144_067)
    end
  end
end
