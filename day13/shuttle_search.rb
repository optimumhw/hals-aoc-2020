# frozen_string_literal: false

require 'pry'
require 'benchmark'

module ShuttleSearch
  class << self
    def compute_product(file_path)
      values = IO.readlines(file_path, chomp: true).map(&:to_s)

      time = values[0].to_i
      buses = values[1].split(',').reject { |x| x == 'x' }.map(&:to_i)
      buses_and_times = buses.map { |n| [n, n - time % n] }.min_by { |k| k[1] }

      buses_and_times[0] * buses_and_times[1]
    end

    # part2 =========================

    def compute_first_time(file_path)
      values = IO.readlines(file_path, chomp: true).map(&:to_s)

      # buses = values[1].split(',')
      buses_times = values[1].split(',')
      .map.with_index{|bus,index| [bus,index]}
      .reject{ |bus,index| bus == 'x'}
      .map{|bus,index| [bus.to_i, index]}

      calc( buses_times )

    end

    def calc(buses_times)

      p = buses_times.reduce(1){|prod, bt| prod * bt[0] }

      sorted = buses_times.sort_by{ |a| a[0] }.reverse

      big_bus = sorted[0][0]
      t = 1

      b = buses_times.map{ |bt| bt[0]}
      pp "      -  #{b[0]}  #{b[1]}  #{b[2]}"
      loop do
        pp "#{t}  :  #{t%b[0]} :  #{ t%b[1]} :  #{t%b[2]}"



        if buses_times.reduce(0){|sum, bus| sum + ( (t + bus[1]) % bus[0] ).abs } == 0
          pp "found it"
          binding.pry
          return t
        end

        t += 1

      end

    end
  end
end

