# frozen_string_literal: true

require_relative '../seat_counter'

describe 'DistributionFinder#find_answer' do
  context 'when given a grid' do
    grid = IO.readlines('spec/small_grid.txt', chomp: true).map(&:to_s).map { |row| row.split('')}

    it 'computes the number of adjacent occupied seats' do
      expect(
        SeatCounter.num_adjacent_occupied(grid, 4, 28)
      ).to eq(7)
    end

    it 'computes the number of adjacent occupied seats at corner' do
      expect(
        SeatCounter.num_adjacent_occupied(grid, 5, 0)
      ).to eq(3)
    end

    it 'throws an error when out of bounds' do
      expect { SeatCounter.num_adjacent_occupied(grid, 6, 0) }.to raise_error(ArgumentError)
    end

    it 'computes the total number of occupied seats' do
      expect(
        SeatCounter.occupied_seat_count(grid)
      ).to eq(10)
    end
  end

  context 'when given the sample input' do
    it 'computes the answer' do
      expect(
        SeatCounter.num_occupied('spec/sample.txt', 1)
      ).to eq(37)
    end
  end

  context 'when given the puzzle input' do
    it 'computes the answer' do
      expect(
        SeatCounter.num_occupied('spec/puzzle_input.txt', 1)
      ).to eq(2472)
    end
  end

  # part 2 -------------------------------------------

  context 'when given a grid' do
    grid = IO.readlines('spec/small_grid_part2.txt', chomp: true).map(&:to_s).map { |row| row.split('')}

    it 'computes the number of visibly occupied seats' do
      expect(
        SeatCounter.num_visible_occupied(grid, 4, 3)
      ).to eq(8)
    end
  end

  context 'when given the sample input' do
    it 'computes the answer' do
      expect(
        SeatCounter.num_occupied('spec/sample.txt', 2)
      ).to eq(26)
    end
  end

  context 'when given the puzzle input' do
    it 'computes the answer' do
      expect(
        SeatCounter.num_occupied('spec/puzzle_input.txt', 2)
      ).to eq(2197)
    end
  end
end
