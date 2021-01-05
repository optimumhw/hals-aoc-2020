# frozen_string_literal: true

require_relative '../conway_cubes'

describe 'ConwayCubes#cubecounter' do

  context 'when given the small sample' do
    it 'counts the cubes' do
      expect(
        ConwayCubes.active_cube_count('spec/small_sample.txt', 6)
      ).to eq(112)
    end
  end

  context 'when given the small sample' do
    it 'counts the cubes' do
      expect(
        ConwayCubes.active_cube_count('spec/puzzle_input.txt', 6)
      ).to eq(386)
    end
  end

end



