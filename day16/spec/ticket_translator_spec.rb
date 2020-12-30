# frozen_string_literal: true

require_relative '../ticket_translator'

describe 'TicketTranslator#scan_error_rate' do
  context 'when given the sample' do
    it 'computes the scan error rate' do
      expect(
        TicketTranslator.scan_error_rate('spec/small_sample_input.txt')
      ).to eq(71)
    end
  end

  context 'when given part1 puzzle input' do
    it 'computes the scan error rate' do
      expect(
        TicketTranslator.scan_error_rate('spec/part1_puzzle_input.txt')
      ).to eq(22_073)
    end
  end

  # ---- part 2 -----------------------------------
  # context 'when given part1 puzzle input' do
  #   it 'computes the product of the fields' do
  #     expect(
  #       TicketTranslator.field_product('spec/part2_sample.txt', %w(row class seat))
  #     ).to eq(11 * 12 * 13)
  #   end
  # end

  context 'when given part2 puzzle input' do
    it 'computes the scan error rate' do
      expect(
        TicketTranslator.field_product('spec/part1_puzzle_input.txt', %w(departure))
      ).to eq(22_073)
    end
  end

end
