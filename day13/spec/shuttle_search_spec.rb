# frozen_string_literal: true

require_relative '../shuttle_search'

describe 'ShuttleSearch#distance' do
  # context 'when given the sample' do
  #   it 'computes id * min' do
  #     expect(
  #       ShuttleSearch.compute_product('spec/sample_input.txt')
  #     ).to eq(295)
  #   end
  # end

  # context 'when given the puzzle input' do
  #   it 'computes id * min' do
  #     expect(
  #       ShuttleSearch.compute_product('spec/puzzle_input.txt')
  #     ).to eq(1915)
  #   end
  # end

  # part2 ========================

  # context 'when given a small array' do
  #   arr =  [[3, 0],[5,1], [7, 2]]
  #   it 'computes the first timestamp' do
  #     expect(
  #       ShuttleSearch.calc( arr)
  #     ).to eq(3417)
  #   end
  # end

  context 'when given a small array' do
    arr =  [[7, 0],[13,2], [19, 3]]
    it 'computes the first timestamp' do
      expect(
        ShuttleSearch.calc( arr)
      ).to eq(3417)
    end
  end



  context 'when given a small array' do
    arr =  [[17, 0],[13,2], [19, 3]]
    it 'computes the first timestamp' do
      expect(
        ShuttleSearch.calc( arr)
      ).to eq(3417)
    end
  end

  # context 'when given the sample' do
  #   it 'computes the first timestamp' do
  #     expect(
  #       ShuttleSearch.compute_first_time('spec/sample_input.txt')
  #     ).to eq(1_068_781)
  #   end
  # end


  # context 'when given the puzzle' do
  #   it 'computes first timestamp' do
  #     expect(
  #       ShuttleSearch.compute_first_time('spec/puzzle_input.txt')
  #     ).to eq(3417)
  #   end
  # end

end
