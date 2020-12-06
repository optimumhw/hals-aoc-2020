# frozen_string_literal: true

require_relative '../seat_finder'

describe 'SeatFinder#seat_id' do

    # BFFFBBFRRR: row 70, column 7, seat ID 567.
    # FFFBBBFRRR: row 14, column 7, seat ID 119.
    # BBFFBBFRLL: row 102, column 4, seat ID 820.


  # context 'when given a boarding pass' do

  #   it 'correctly calculates the corresponding seat id' do
  #     expect(
  #       SeatFinder.seat_info('FBFBBFFRLR', 128, 8)
  #     ).to eq(357)
  #   end
  # end

  # context 'when given a boarding pass' do

  #   it 'correctly calculates the corresponding seat id' do
  #     expect(
  #       SeatFinder.seat_info('BFFFBBFRRR', 128, 8)
  #     ).to eq(567)
  #   end
  # end

  # context 'when given a small list of boarding passes' do

  #   it 'finds the highest seat id' do
  #     expect(
  #       SeatFinder.highest_seatid('spec/sample_input.txt',128,8)
  #     ).to eq(820)
  #   end
  # end

  # context 'when given puzzle input of boarding passes' do

  #   it 'finds the highest seat id' do
  #     expect(
  #       SeatFinder.highest_seatid('spec/aoc_puzzle_input.txt', 128, 8)
  #     ).to eq(928)
  #   end
  # end

  # part 2 ==========================================

  context 'when given paramaters' do
    it 'locate returns the moves' do
      expect(
        SeatFinder.locate( [], ['F','B'], 16, 2, 11, 11  )
      ).to eq(['F','F','B','F'])
    end
  end

  context 'when given paramaters' do
    it 'locate returns the moves' do
      expect(
        SeatFinder.locate( [], ['L','R'], 8, 2, 5, 5  )
      ).to eq(['L','R','L'])
    end
  end

  context 'when given a seat id' do

    it 'correctly calculates the corresponding boarding pass' do
      expect(
        SeatFinder.boarding_pass(357, 128, 8)
      ).to eq('FBFBBFFRLR')
    end
  end

  context 'when given a seat id' do

    it 'correctly calculates the corresponding boarding pass' do
      expect(
        SeatFinder.boarding_pass(820, 128, 8)
      ).to eq('BBFFBBFRLL')
    end
  end

  context 'when given a list of boarding passes' do

    it 'finds the seat id of the missing boarding pass' do
      expect(

        SeatFinder.missing_seat_id('spec/aoc_puzzle_input.txt', 128, 8)

      ).to eq(610)
    end
  end

end

