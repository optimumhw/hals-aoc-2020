# frozen_string_literal: true

require_relative '../recitation'

describe 'recitation#spoken_number' do
  context 'when given the sample' do
    it 'computes the spoken number' do
      expect(
        Recitation.fast_spoken_number(2020, [0, 3, 6])
      ).to eq(436)
    end
  end

  context 'when given the sample' do
    it 'computes the spoken number' do
      expect(
        Recitation.fast_spoken_number(2020, [1, 3, 2])
      ).to eq(1)
    end
  end

  context 'when given the sample' do
    it 'computes the spoken number' do
      expect(
        Recitation.fast_spoken_number(2020, [3, 1, 2])
      ).to eq(1836)
    end
  end

  context 'when given the puzzle input' do
    it 'computes the spoken number' do
      expect(
        Recitation.fast_spoken_number(2020, [19, 20, 14, 0, 9, 1])
      ).to eq(1325)
    end
  end

  # part 2 ====================================

  context 'when given the sample' do
    it 'quickly computes the spoken number' do
      expect(
        Recitation.fast_spoken_number(30000000, [0, 3, 6])
      ).to eq(175594)
    end
  end

  context 'when given the sample' do
    it 'quickly computes the spoken number' do
      expect(
        Recitation.fast_spoken_number(30000000, [1, 3, 2])
      ).to eq(2578)
    end
  end

  context 'when given the puzzle input' do
    it 'quickly computes the spoken number' do
      expect(
        Recitation.fast_spoken_number(30000000, [19,20,14,0,9,1])
      ).to eq(59006)
    end
  end

end
