# frozen_string_literal: false

require 'pry'
require 'benchmark'
require 'pry-byebug'

module ShuttleSearch
  class << self

    # part1 ========================
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

 
    # helper methods for part 2 ===============

    def gcd( a, b)
      a%b >= 1 ? gcd( b, a%b ) : b
    end

    def relatively_prime?( a, b)
     gcd( b, a ) == 1 ? true : false
    end

    def bezout( a, b )

      arr = bezout_rec( a, b, a/b, a%b, 1, 0, 1, 0, 1, -1 * (a/b) )
      {"gcd" => arr[1], "x" => arr[5], "y" => arr[8]}

    end

    def bezout_rec( a, b, q, r, s1, s2, s3, t1, t2, t3 )

      return [ a, b, q, r, s1, s2, s3, t1, t2, t3 ] unless r != 0

      a = b
      b = r
      q = a / b
      r = a - q*b
      s1 = s2
      s2 = s3
      t1 = t2
      t2 = t3

      s3 = s1-q*s2
      t3 = t1 - q*t2

      bezout_rec( a, b, q, r, s1, s2, s3, t1, t2, t3 )
      
    end

    def multInverse!( x, n )
      raise_error unless relatively_prime?(x,n)
      x = ShuttleSearch.bezout( x, n )["x"]
      x < 0 ? x + n : x 
    end

    def all_relatively_prime?( arr )
      arr.combination(2).to_a
      .reject{ |a, b| relatively_prime?(a,b) }
      .empty?
    end


    def compute_ni_product( bus_ids_and_index, bus_index )
      bus_ids_and_index.reject { |bus_id, index | index == bus_index }
      .map{ |bus_id, index| bus_id}
      .reduce(:*)
    end

    # part2 =========================
    def compute_first_time_from_file(file_path)
      values = IO.readlines(file_path, chomp: true).map(&:to_s)

      bus_ids_and_mins = values[1].split(',')
      .each_with_index.map{ |s, index| [s.to_i,s.to_i - index] }
      .reject { |bus_id,mins| bus_id == 0 }

      compute_first_time!(bus_ids_and_mins)

    end

    def compute_first_time!(bus_ids_and_mins)

      bus_ids = bus_ids_and_mins.map{ |bus_id, mins| bus_id }
      raise_error unless all_relatively_prime?(bus_ids)

      bus_ids_and_index = bus_ids.each_with_index.map{|b,index| [b, index]}

      bus_ids_and_mins
      .each_with_index
      .map{ |b_and_m,index| [b_and_m[1], 
      compute_ni_product( bus_ids_and_index, index ), 
      multInverse!( compute_ni_product( bus_ids_and_index, index ), b_and_m[0] ) ] }
      .map{ |arr| arr[0]*arr[1]*arr[2]}
      .reduce(:+) % bus_ids.map{ |bus_id, index| bus_id}.reduce(:*)

    end

  end
end








