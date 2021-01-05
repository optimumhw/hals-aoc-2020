
require 'pry'
require 'benchmark'

module ConwayCubes
  class << self

    ACTIVE = 1
    INACTIVE = 0


    def active_cube_count(file_path, num_cycles)
      input = IO.readlines(file_path, chomp: true).map(&:to_s)
        .map{|s| s.split("")}.map{|p| p.map{|z| (z=="#" ? 1 : 0 )}}

      grid = [input]

      (0..num_cycles-1).each do |n|
        grid = cycle( grid )
      end

      number_active( grid )

    end

    def cycle( grid )
      new_grid = enlarge_grid( grid )
      set_values( new_grid )
    end

    def set_values( grid )
      h = grid.length - 1
      w = grid[0].length - 1
      temp_grid = (0..h).map{ |z| (0..w).map{ |y| (0..w).map{|x| INACTIVE}}}
      (0..h).each do |z|
        (0..w).each do |y|
          (0..w).each do |x|
            sum = sum_of_neighbors( grid, z,y,x )

            if grid[z][y][x] == ACTIVE
              temp_grid[z][y][x] = (sum == 2 || sum == 3) ? ACTIVE : INACTIVE
            else
              temp_grid[z][y][x] = (sum == 3) ? ACTIVE : INACTIVE
            end
          end
        end
      end

      temp_grid
    end

    def sum_of_neighbors( grid, z,y,x )

      sum = 0
      (-1..1).each do |k|
        (-1..1).each do |j|
          (-1..1).each do |i|
            next if i.zero? && j.zero? && k.zero?
            next if !inbounds?( grid, z+k, y+j, x+i)
            sum += grid[z+k][y+j][x+i]
          end
        end
      end
      sum
    end

    def inbounds?( grid, z,y,x)
      ordinate_inbounds?( grid.length, z) &&
      ordinate_inbounds?( grid[0].length, y) &&
      ordinate_inbounds?( grid[0].length, x)
    end

    def ordinate_inbounds?( length, ordinate)
      ordinate >= 0 && ordinate < length
    end


    def enlarge_grid( grid )
      h = grid.length + 1
      w = grid[0].length + 1
      new_grid = (0..h).map{ |z| (0..w).map{ |y| (0..w).map{|x| INACTIVE}}}
      (0..h).each do |z|
        (0..w).each do |y|
          (0..w).each do |x|
            next if !inbounds?( grid, z-1,y-1,x-1)
            new_grid[z][y][x] = grid[z-1][y-1][x-1]
          end
        end
      end
      new_grid
    end

    def number_active( grid )
      h = grid.length - 1
      w = grid[0].length - 1
      sum = 0
      (0..h).each do |z|
        (0..w).each do |y|
          (0..w).each do |x|
            sum += grid[z][y][x]
          end
        end
      end
      sum
    end

  end
end
