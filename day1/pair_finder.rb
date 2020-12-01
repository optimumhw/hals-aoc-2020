# frozen_string_literal: true

require 'pry'
require 'benchmark'

module PairFinder
  class << self
    def find_product(target_value, tuple_size, numbers)
      numbers.select { |n| n < target_value }
             .combination(tuple_size)
             .to_a
             .select { |t| t.inject(0, :+) == target_value }[0]
             .inject(1) { |product, n| product * n }
    end
  end
end
