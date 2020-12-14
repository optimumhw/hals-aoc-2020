# frozen_string_literal: true

require 'pry'
require 'benchmark'

module ValueFinder
  class << self
    def find_bad_value(file_path, preamble_length)
      values = IO.readlines(file_path, chomp: true).map(&:to_i)
      find_value(values, preamble_length)
    end

    def find_weakness(file_path, preamble_length)
      values = IO.readlines(file_path, chomp: true).map(&:to_i)
      bad_value = find_value(values, preamble_length)

      find_value_in_sum(values, bad_value)
    end

    def find_value(values, preamble_length)
      index = 0

      while index < values.length - preamble_length
        return values[index + preamble_length] if
          values.slice(index, preamble_length)
                .combination(2)
                .select { |a, b| a + b == values[index + preamble_length] }.empty?

        index += 1

      end
    end

    def find_value_in_sum(values, bad_value)
      index = 0

      while index < values.length - 1

        end_index = index + 1

        while end_index < values.length

          arr = values.slice(index..end_index)
          total = arr.map.reduce { |sum, n| sum + n }
          return arr.min + arr.max if total == bad_value

          end_index += 1

        end
        index += 1
      end
      0
    end
  end
end
