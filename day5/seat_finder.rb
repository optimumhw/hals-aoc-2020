# frozen_string_literal: true

require 'pry'
require 'benchmark'

module SeatFinder
  class << self

    UP = 0
    DOWN = 1

    def highest_seatid(file_path, num_rows, num_columns)
      IO.readlines(file_path, chomp: true)
      .map{ |boarding_pass| seat_info( boarding_pass, num_rows, num_columns)}
      .max
    end

    def seat_info( boarding_pass, num_rows, num_columns)
      index = [
        ((boarding_pass.include? "L" ) ?  boarding_pass.index('L') : Float::INFINITY),
        ((boarding_pass.include? "R" ) ?  boarding_pass.index('R') : Float::INFINITY)].min

      row_moves = boarding_pass[0..index-1].split("").map{|c| c=="F" ? UP : DOWN}
      column_moves = boarding_pass[index..-1].split("").map{|c| c=="L" ? UP : DOWN}

      row_index = move( row_moves, 0, num_rows-1 )
      column_index = move( column_moves, 0, num_columns-1 )
      (row_index * num_columns) + column_index

    end

    def move( moves, lower_bound, upper_bound  )
      if moves.length == 1
        moves[0] == UP ? [lower_bound, upper_bound].min : [lower_bound, upper_bound].max
      else
        if moves[0] == UP
          move( moves[1..-1],
            lower_bound,  ((lower_bound + upper_bound + 1) / 2) - 1)
        else
          move( moves[1..-1],
            (lower_bound + upper_bound + 1) / 2, upper_bound)
        end
      end

    end


    # --- part2 ---------------------------------
    def missing_seat_id(file_path, num_rows, num_columns)

      boarding_passes = IO.readlines(file_path, chomp: true)

      ids = (0..1023).map{ |seat_id|
          [seat_id, boarding_pass( seat_id, num_rows, num_columns )]
      }.select{ |seat_id, bp|
        seat_id > num_columns &&
        seat_id < num_columns * (num_rows -1 ) &&
        !boarding_passes.include?(bp)
      }
      .map{|seat_id, bp| seat_id }

      ids.select{ |id|
          !ids.include?(id-1) && !ids.include?(id+1)
      }.max

    end

    def boarding_pass( seat_id, num_rows, num_columns )

      row_index = seat_id / num_columns
      col_index = seat_id % num_columns

      moves = []
      locate( moves, ['R', 'L'], 8, 2, col_index, col_index )
      locate( moves, ['B', 'F'], 128, 2, row_index, row_index  )
      moves.reverse.join

    end

    def locate( moves, directions, length, divisor, plower, pupper  )

      num_blocks = length / divisor
      tlb = 0
      tub = 0

      (0..num_blocks).each do |block_index|
        lower_bound = block_index * divisor
        upper_bound = ((block_index+1) * divisor) - 1

        if plower >= lower_bound && pupper <= upper_bound

          tlb = lower_bound
          tub = upper_bound

          if plower == lower_bound
            moves << directions[1]
          else
            moves << directions[0]
          end
        end
      end

      if num_blocks == 1
        moves
      else
        locate( moves, directions, length, divisor*2, tlb, tub  )
      end

    end

  end
end
