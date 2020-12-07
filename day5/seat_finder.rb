# frozen_string_literal: true

require 'pry'
require 'benchmark'

module SeatFinder
  class << self
    UP = 0
    DOWN = 1

    def highest_seatid(file_path, num_rows, num_columns)
      IO.readlines(file_path, chomp: true)
        .map { |boarding_pass| seat_info(boarding_pass, num_rows, num_columns) }
        .max
    end

    def seat_info(boarding_pass, num_rows, num_columns)
      # split the boarding pass into row_moves and column_moves
      index = [
        ((boarding_pass.include? 'L') ?  boarding_pass.index('L') : Float::INFINITY),
        ((boarding_pass.include? 'R') ?  boarding_pass.index('R') : Float::INFINITY)
      ].min

      row_moves = boarding_pass[0..index - 1].split('').map { |c| c == 'F' ? UP : DOWN }
      column_moves = boarding_pass[index..-1].split('').map { |c| c == 'L' ? UP : DOWN }

      # compute the seat's row index from the row_moves
      row_index = move(row_moves, 0, num_rows - 1)

      # compute the seat's column indes from the column moves
      column_index = move(column_moves, 0, num_columns - 1)

      # calculate the seat id
      (row_index * num_columns) + column_index
    end

    def move(moves, lower_bound, upper_bound)
      if moves.length == 1
        moves[0] == UP ? [lower_bound, upper_bound].min : [lower_bound, upper_bound].max
      elsif moves[0] == UP
        move(moves[1..-1],
             lower_bound, ((lower_bound + upper_bound + 1) / 2) - 1)
      else
        move(moves[1..-1],
             (lower_bound + upper_bound + 1) / 2, upper_bound)
      end
    end

    # --- part2 ---------------------------------
    def missing_seat_id(file_path, num_rows, num_columns)
      boarding_passes = IO.readlines(file_path, chomp: true)

      last_seat = num_rows * num_columns - 1

      # run through all the seat_ids on the plane and
      # compute their boarding passes. exclude the seat_ids
      # that have a boarding pass in the list.
      seat_ids_wo_boarding_passes = (0..last_seat).map do |seat_id|
        [seat_id, boarding_pass(seat_id, num_rows, num_columns)]
      end.reject  do |seat_id, bp|
        seat_id < num_columns ||
          seat_id >= num_columns * (num_rows - 1) ||
          boarding_passes.include?(bp)
      end
                                                  .map { |seat_id, _bp| seat_id }

      # of the seats w/o boarding passes, exclude the one(s) where
      # the neighboring seats are also missing
      seat_ids_wo_boarding_passes.reject do |seat_id|
        (seat_ids_wo_boarding_passes.include?(seat_id - 1) ||
            seat_ids_wo_boarding_passes.include?(seat_id + 1))
      end.max
    end

    def boarding_pass(seat_id, _num_rows, num_columns)
      row_index = seat_id / num_columns
      col_index = seat_id % num_columns

      moves = []
      generate_moves_to_seat(moves, %w[R L], 8, 2, col_index, col_index)
      generate_moves_to_seat(moves, %w[B F], 128, 2, row_index, row_index)
      moves.reverse.join
    end

    def generate_moves_to_seat(moves, directions, length, divisor, lower_bound, upper_bound)
      num_blocks = length / divisor

      next_lower_bound = 0
      next_upper_bound = 0

      (0..num_blocks).each do |block_index|
        next_lower_bound = block_index * divisor
        next_upper_bound = ((block_index + 1) * divisor) - 1

        next unless lower_bound >= next_lower_bound && upper_bound <= next_upper_bound

        moves << if lower_bound == next_lower_bound
                   directions[1]
                 else
                   directions[0]
                 end
        break
      end

      if num_blocks == 1
        moves
      else
        generate_moves_to_seat(moves, directions, length, divisor * 2, next_lower_bound, next_upper_bound)
      end
    end
  end
end
