# frozen_string_literal: true

require_relative '../password_validator'

describe 'PasswordValidator#count_valid_passwords' do
  context 'when given a small list of rules/passwords' do
    file_data = File.read('spec/sample_input.txt').split

    it 'counts the number of valid passwords' do
      expect(
        PasswordValidator.count_valid_passwords(file_data)
      ).to eq(2)
    end
  end

  context 'when given a small list of rules/passwords' do
    file_data = File.read('spec/more_sample_input.txt').split

    it 'counts the number of valid passwords' do
      expect(
        PasswordValidator.count_valid_passwords(file_data)
      ).to eq(2)
    end
  end

  context 'when given puzzle input list of rules/passwords' do
    file_data = File.read('spec/puzzle_input.txt').split

    it 'counts the number of valid passwords' do
      expect(
        PasswordValidator.count_valid_passwords(file_data)
      ).to eq(465)
    end
  end

  context 'when given a small list of part2 rules/passwords' do
    file_data = File.read('spec/part2_sample_input.txt').split

    it 'counts the number of valid passwords' do
      expect(
        PasswordValidator.count_part2_valid_passwords(file_data)
      ).to eq(1)
    end
  end

  context 'when given puzzle input list of rules/passwords' do
    file_data = File.read('spec/puzzle_input.txt').split

    it 'counts the number of valid passwords' do
      expect(
        PasswordValidator.count_part2_valid_passwords(file_data)
      ).to eq(294)
    end
  end
end
