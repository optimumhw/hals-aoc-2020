# frozen_string_literal: true

require 'pry'
require 'benchmark'

module SeatCounter
  class << self
    PART1 = 1
    PART2 = 2

    NW = [-1, -1].freeze
    N = [-1, 0].freeze
    NE = [-1, 1].freeze
    E = [0, 1].freeze

    SE = [1, 1].freeze
    S = [1, 0].freeze
    SW = [1, -1].freeze
    W = [0, -1].freeze

    DIRECTIONS = [NW, N, NE, E, SE, S, SW, W].freeze

    def num_occupied(file_path, part)
      values = IO.readlines(file_path, chomp: true).map(&:to_s)

      grid = values.map { |row| row.split('') }
      osc = occupied_seat_count(grid)

      loop do
        new_grid = part == PART1 ? apply_rules(grid) : apply_rules_part2(grid)
        if grids_match?(grid, new_grid)
          osc = occupied_seat_count(grid)
          break
        end
        grid = new_grid
      end

      osc
    end

    def occupied_seat_count(grid)
      count = 0
      (0..(grid.length - 1)).each do |row_index|
        (0..(grid[0].length - 1)).each do |col_index|
          count += 1 if grid[row_index][col_index] == '#'
        end
      end
      count
    end

    # empty (L) and  no occupied seats adjacent --> occupied #
    # occupied (#) and four or more seats adjacent occupied --> empty L
    # Otherwise, the seat's state does not change.

    def apply_rules(grid)
      new_grid = deep_copy_grid(grid)
      (0..(grid.length - 1)).each do |row|
        (0..(grid[0].length - 1)).each do |col|
          count = num_adjacent_occupied(grid, row, col)

          if grid[row][col] == 'L' && num_adjacent_occupied(grid, row, col).zero?
            new_grid[row][col] = '#'
          elsif grid[row][col] == '#' && num_adjacent_occupied(grid, row, col) >= 4
            new_grid[row][col] = 'L'
          end
        end
      end

      new_grid
    end

    def deep_copy_grid(grid)
      grid_clone = []
      (0..(grid.length - 1)).each do |row|
        row_clone = []
        (0..(grid[0].length - 1)).each do |col|
          row_clone[col] = grid[row][col]
        end
        grid_clone[row] = row_clone
      end
      grid_clone
    end

    def num_adjacent_occupied(grid, row, col)
      raise ArgumentError, 'cooridinates are out of bounds!' unless inbounds?(grid, row, col)

      count = 0
      (0..2).each do |row_index|
        (0..2).each do |col_index|
          check_row = row - 1 + row_index
          check_col = col - 1 + col_index

          next unless (check_row != row || check_col != col) &&
                      inbounds?(grid, check_row, check_col) &&
                      grid[check_row][check_col] == '#'

          count += 1
        end
      end
      count
    end

    def inbounds?(grid, row, col)
      row >= 0 &&
        row < grid.length &&
        col >= 0 &&
        col < grid[0].length
    end

    def grids_match?(grid_A, grid_B)
      return false if grid_A.length != grid_B.length
      return false if grid_A[0].length != grid_B[0].length

      (0..(grid_A.length - 1)).each do |row_index|
        (0..(grid_A[0].length - 1)).each do |col_index|
          return false if grid_A[row_index][col_index] != grid_B[row_index][col_index]
        end
      end

      true
    end

    # part 2 ---------------------------------------

    # empty (L) and  no occupied seats visible --> occupied #
    # occupied (#) and five or more visible seats occupied --> empty L
    # Otherwise, the seat's state does not change.

    def apply_rules_part2(grid)
      new_grid = deep_copy_grid(grid)
      (0..(grid.length - 1)).each do |row|
        (0..(grid[0].length - 1)).each do |col|

          if grid[row][col] == 'L' && num_visible_occupied(grid, row, col) == 0
            new_grid[row][col] = '#'
          elsif grid[row][col] == '#' && num_visible_occupied(grid, row, col) >= 5
            new_grid[row][col] = 'L'
          end

        end
      end

      new_grid
    end

    def num_visible_occupied(grid, row, col)
      raise ArgumentError, 'cooridinates are out of bounds!' unless inbounds?(grid, row, col)

      count = 0

      DIRECTIONS.map
                .reduce(0) do |sum, direction|
        sum + (
          occupied_seat_on_line?(grid, row, col, direction) ? 1 : 0
        )
      end
    end

    def occupied_seat_on_line?(grid, row, col, direction)
      check_row = row
      check_col = col

      while inbounds?(grid, check_row, check_col)
        unless check_row == row && check_col == col
          return true if grid[check_row][check_col] == '#'
          return false if grid[check_row][check_col] == 'L'
        end
        check_row += direction[0]
        check_col += direction[1]
      end

      false
    end
  end
end
