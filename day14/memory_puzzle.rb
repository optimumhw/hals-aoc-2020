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
      or_mask = mask.gsub(/[X]/, '0').to_i(2)
      and_mask = mask.gsub(/[X]/, '1').to_i(2)
      (number | or_mask) & and_mask
    end
  end
end
