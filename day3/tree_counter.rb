require 'pry'
require 'benchmark'

module TreeCounter
  class << self
    def count_trees(file_path, slopes)
      file = File.open(file_path)
      file_data = file.readlines.map(&:chomp)
      file.close

      grid = file_data.map { |string| string.chars.to_a }

      slopes.map { |right, down| sum_trees(grid, right, down) }.inject(:*)
    end

    def sum_trees(grid, right, down)
      width = grid[0].length
      num_rows = grid.length
      sum = 0
      row_index = 0
      col_index = 0

      loop do
        col_index = (col_index + right) % width
        row_index += down

        return sum if row_index >= num_rows

        sum += 1 if grid[row_index][col_index] == '#'
      end
    end
  end
end
