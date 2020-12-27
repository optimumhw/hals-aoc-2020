# frozen_string_literal: false

require 'pry'
require 'benchmark'

module MemoryPuzzle
  class << self
    def mem_sum(file_path)
      values = IO.readlines(file_path, chomp: true).map(&:to_s)

      arr = values.map { |v| v.gsub(/\s+/, '').split('=') }

      memory = {}
      mask = ''
      arr.each do |pair|
        if pair[0] == 'mask'
          mask = pair[1]
        else
          address = pair[0].match(/(\d+)/).captures[0]
          value = apply_mask(mask, pair[1].to_i)
          memory.store(address, value)
        end
      end
      memory.map { |_k, v| v }.reduce(0) { |sum, v| sum + v }
    end

    def apply_mask(mask, number)
      or_mask = mask.gsub('X', '0').to_i(2)
      and_mask = mask.gsub('X', '1').to_i(2)
      (number | or_mask) & and_mask
    end

    # part 2 =========================================

    def change_memory(file_path)
      values = IO.readlines(file_path, chomp: true).map(&:to_s)

      arr = values.map { |v| v.gsub(/\s+/, '').split('=') }

      memory = {}
      mask = ''

      arr.each do |pair|
        if pair[0] == 'mask'
          mask = pair[1]
        else
          start_address = pair[0].match(/(\d+)/).captures[0].to_i
          locations = addresses(mask, start_address)

          locations.map { |a| memory.store(a, pair[1].to_i)}

        end
      end
      memory.map { |_k, v| v }.reduce(0) { |sum, v| sum + v }
    end

    def addresses(mask, start_address)
      zeros_for_xs = mask.gsub('X', '0').to_i(2)
      and_mask = mask.gsub('0', '1').gsub('X', '0').to_i(2)

      mask_applied = start_address | zeros_for_xs
      final = mask_applied & and_mask

      float_mask = mask.gsub('1', '0').gsub('X', '1').to_i(2)
      twos = (0..35).map { |n| (2**(35 - n) & float_mask) }.select { |n| n.positive? }

      combos = (0..twos.length).map { |n| twos.combination(n) }
      or_masks = combos.map { |z| z.map { |q| q}}.flatten(1).map { |a| a.reduce(0) { |s, v| s + v}}

      or_masks.map { |n| (n | final)}
    end
  end
end
