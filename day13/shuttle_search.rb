# frozen_string_literal: false

require 'pry'
require 'benchmark'

module ShuttleSearch
  class << self
    def compute_product(file_path)
      values = IO.readlines(file_path, chomp: true).map(&:to_s)

      est_dep_time = values[0].to_i
      buses = values[1].split(',').reject { |x| x == 'x' }.map(&:to_i)

      # for each bus id n, the
      # seconds to wait from est_dep_time until next 
      # multiple of n is n - (est_dep_time % n)
      buses_and_times = buses.map { |n| [n, n - est_dep_time % n] }.min_by { |k| k[1] }

      buses_and_times[0] * buses_and_times[1]
    end

    # part2 =========================

    def compute_first_time(file_path)
      values = IO.readlines(file_path, chomp: true).map(&:to_s)

      buses_times = values[1].split(',')
      .map.with_index{|bus,index| [bus,index]}
      .reject{ |bus,index| bus == 'x'}
      .map{|bus,index| [bus.to_i, index]}

      calc( buses_times )

    end

    def calc(buses_times)

      starting_bus_id = buses_times[0][0]


      t = 1
      loop do
        if buses_times.reduce(0){|sum, bus| sum + (matches( starting_bus_id, t, bus[0], bus[1] ) ? 0 : 1) } == 0
          return t
        end
        t += 1
      end

    end

    def matches( starting_bus_id, t, bus_id, offset )
      starting_bus_id == bus_id ? t % bus_id == 0 : bus_id - t%bus_id == offset 
    end
  end
end

