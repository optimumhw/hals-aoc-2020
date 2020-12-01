# frozen_string_literal: true

require 'pry'
require 'benchmark'

module PairFinder
  class << self
    def find_pair(target_value, numbers)
      winner = numbers.select { |n| n < target_value }.combination(2).to_a.select { |a, b| a + b == target_value }[0]
      winner[0] * winner[1]
    end

    def find_trips(target_value, numbers)
      winner = numbers.select { |n| n < target_value }.combination(3).to_a.select { |a, b, c| a + b + c == target_value }[0]
      winner[0] * winner[1] * winner[2]
    end
  end
end
