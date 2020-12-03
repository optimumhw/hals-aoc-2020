require 'pry'
require 'benchmark'

module TreeCounter
  class << self
    def count_trees(file_path)
      file = File.open(file_path)
      file_data = file.readlines.map(&:chomp)
      file.close

      grid = file_data.map { |string| string.chars.to_a }
      sum_trees(grid)
    end

    def sum_trees(grid)
      width = grid[0].length
      num_rows = grid.length
      sum = 0
      row_index = 0
      col_index = 0

      loop do
        col_index = (col_index + 3) % width
        row_index += 1

        return sum if row_index >= num_rows

        sum += 1 if grid[row_index][col_index] == '#'
      end
    end
  end
end
