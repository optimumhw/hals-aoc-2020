require 'pry'
require 'benchmark'
require 'json'

module AnswerCounter
  class << self
    def count_answers(file_path)
      file_data = File.read(file_path)

      file_data
        .split(/\n{2,}/)
        .map { |blob| blob.split(/\n/) }
        .map { |group| group.join}
        .map do |group|
        group.scan(/\w/).each_with_object(Hash.new(0)) { |i, h| h[i] += 1; }.length
      end.inject(:+)
    end

    # part 2 ===========================
    def count_yes_answers_to_all_questions(file_path)
      file_data = File.read(file_path)

      groups = file_data
        .split(/\n{2,}/)
        .map { |blob| blob.split(/\n/) }

      group_sizes = groups.map { |group| group.length }

      group_answers = groups.map { |group| group.join}
      .map do |group|
        group.scan(/\w/).each_with_object(Hash.new(0)) { |i, h| h[i] += 1; }
      end

      group_sizes.each_with_index.map do |_count, idx|
        group_answers[idx].select { |_key, value| value == group_sizes[idx]}.length
      end.inject(:+)
    end
  end
end
