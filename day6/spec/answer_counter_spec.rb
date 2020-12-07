require_relative '../answer_counter'

describe 'AnswerCounter#count_valid_passports' do
  context 'when given the sample input' do
    it 'counts the answers' do
      expect(
        AnswerCounter.count_answers('spec/sample_input.txt')
      ).to eq(11)
    end
  end

  context 'when given my part1 input' do
    it 'counts the answers' do
      expect(
        AnswerCounter.count_answers('spec/puzzle_input.txt')
      ).to eq(6583)
    end
  end

  # part2 ------------------------------

  context 'when given the sample input' do
    it 'counts yes answers to all questions' do
      expect(
        AnswerCounter.count_yes_answers_to_all_questions('spec/sample_input.txt')
      ).to eq(6)
    end
  end

  context 'when given my part1 input' do
    it 'counts yes answers to all questions' do
      expect(
        AnswerCounter.count_yes_answers_to_all_questions('spec/puzzle_input.txt')
      ).to eq(3290)
    end
  end
end
