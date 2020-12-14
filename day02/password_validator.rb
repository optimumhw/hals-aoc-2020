# frozen_string_literal: true

require 'pry'
require 'benchmark'

module PasswordValidator
  class << self
    def count_valid_passwords(file_data)
      file_data.each_slice(3)
               .to_a
               .select { |range, letter, password| validate_p1?(range, letter, password) }.size
    end

    def validate_p1?(range, letter, password)
      min = range.split('-')[0].to_i
      max = range.split('-')[1].to_i
      letter_count = password.count letter
      letter_count >= min && letter_count <= max
    end

    def count_part2_valid_passwords(file_data)
      file_data.each_slice(3)
               .to_a
               .select { |range, letter, password| validate_p2?(range, letter[0], password) }.size
    end

    def validate_p2?(range, letter, password)
      index_left = range.split('-')[0].to_i - 1
      index_right = range.split('-')[1].to_i - 1

      (password[index_left] == letter && password[index_right] != letter) ||
        (password[index_left] != letter && password[index_right] == letter)
    end
  end
end
