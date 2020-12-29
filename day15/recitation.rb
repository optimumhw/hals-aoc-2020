# frozen_string_literal: false

require 'pry'
require 'benchmark'

module Recitation
  class << self


    # ======= part 1 & 2 ========================
    def fast_spoken_number(ordinal, words)

      last_spoken = words.last
      words_table = words.map.with_index{|w,i| [w,[i+1,nil]]}.to_h

      turn = words.length + 1
      loop do

        if words_table[last_spoken][1].nil?
          last_spoken = 0
          update_or_append( words_table, last_spoken, turn)
        else
          last_spoken = words_table[last_spoken][0] - words_table[last_spoken][1]
          update_or_append( words_table, last_spoken, turn)
        end
        turn +=1
        return last_spoken if turn > ordinal

      end
    end

    def update_or_append( words_table, word, turn)
      if words_table.key?(word)
        words_table[word][1] = words_table[word][0]
        words_table[word][0] = turn
      else
        words_table[word] = [turn, nil]
      end
    end

  end
end
