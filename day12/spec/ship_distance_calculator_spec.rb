# frozen_string_literal: true

require_relative '../ship_distance_calculator'

describe 'ShipDistanceCalculator#distance' do
  context 'when given a sample set of instructions' do
    it 'computes the distance' do
      expect(
        ShipDistanceCalculator.distance('spec/sample_input.txt')
      ).to eq(25)
    end
  end

  context 'when given the test set of instructions' do
    it 'computes the distance' do
      expect(
        ShipDistanceCalculator.distance('spec/test_sample.txt')
      ).to eq(0)
    end
  end

  context 'when given the puzzle input' do
    it 'computes the distance' do
      expect(
        ShipDistanceCalculator.distance('spec/puzzle_input.txt')
      ).to eq(1482)
    end
  end

  # -- part2 ----------------------

  context 'when given an angle and a waypoint' do
    it 'rotates the waypoint' do
      expect(
        ShipDistanceCalculator.rotate_wp([10, 4], -90)
      ).to eq([4, -10])
    end

    it 'rotates the waypoint' do
      expect(
        ShipDistanceCalculator.rotate_wp([-4, 2], 90)
      ).to eq([-2, -4])
    end

    it 'rotates the waypoint' do
      expect(
        ShipDistanceCalculator.rotate_wp([1, 1], 270)
      ).to eq([1, -1])
    end

    it 'rotates the waypoint' do
      expect(
        ShipDistanceCalculator.rotate_wp([-1, 10], -180)
      ).to eq([1, -10])
    end

    it 'rotates the waypoint' do
      expect(
        ShipDistanceCalculator.rotate_wp([-1, 10], 180)
      ).to eq([1, -10])
    end
  end

  context 'when given some directions' do
    it 'computes the manhattan distance' do
      expect(
        ShipDistanceCalculator.wp_compute_distance([['F', 3]])
      ).to eq(33)
    end
  end

  context 'when given a sample set of instructions' do
    it 'computes the manhattan distance' do
      expect(
        ShipDistanceCalculator.manhattan_distance('spec/sample_input.txt')
      ).to eq(286)
    end
  end

  context 'when given the puzzle input' do
    it 'computes the manhattan distance' do
      expect(
        ShipDistanceCalculator.manhattan_distance('spec/puzzle_input.txt')
      ).to eq(48_739)
    end
  end
end
