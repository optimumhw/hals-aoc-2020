# frozen_string_literal: true

require 'pry'
require 'benchmark'

module DistributionFinder
  class << self
    def find_answer(file_path)
      values = IO.readlines(file_path, chomp: true).map(&:to_i)

      find_product(values)
    end

    def find_product(values)
      arr = find_value_array(values)
      arr[0] * arr[2]
    end

    def find_value_array(values)
      values << 0
      values << values.max + 3
      sorted = values.sort

      indexes_and_values = sorted.map.with_index { |value, index| [index, value] }

      diffs = indexes_and_values.slice(1..indexes_and_values.length - 1).map { |arr| arr[1] - sorted[arr[0] - 1] }

      count_of_one_diffs = diffs.select { |n| n == 1 }.length
      count_of_two_diffs = diffs.select { |n| n == 2}.length
      count_of_three_diffs = diffs.select { |n| n == 3}.length

      [count_of_one_diffs, count_of_two_diffs, count_of_three_diffs]
    end

    # part 2 ---------------------------
    def quick_count(file_path)
      unsorted_values = IO.readlines(file_path, chomp: true).map(&:to_i)

      quick_count_values(unsorted_values)
    end

    def quick_count_values(unsorted_values)
      values = unsorted_values.sort.reverse

      sums = (0..(values.length - 1)).map { |_n| 0 }

      a = 1
      b = a + (values[values.length - 2] <= 3 ? 1 : 0)
      c = a + b + (values[values.length - 3] <= 3 ? 1 : 0)

      sums[sums.length - 1] = a
      sums[sums.length - 2] = b
      sums[sums.length - 3] = c

      (3..(values.length - 1)).each do |n|
        index = (values.length - 1) - n

        a = (values[index] - values[index + 3] <= 3 ? sums[index + 3] : 0)
        b = (values[index] - values[index + 2] <= 3 ? sums[index + 2] : 0)
        c = (values[index] - values[index + 1] <= 3 ? sums[index + 1] : 0)

        sums[index] = a + b + c
      end

      sums[0]
    end
  end
end
