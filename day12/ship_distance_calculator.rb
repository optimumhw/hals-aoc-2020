# frozen_string_literal: false

require 'pry'
require 'benchmark'

module ShipDistanceCalculator
  class << self
    def distance(file_path)
      values = IO.readlines(file_path, chomp: true).map(&:to_s)
      directions = values.map { |s| [s[0], s[1..-1].to_i] }
      compute_distance(directions)
    end

    def compute_distance(directions)
      horz = 0
      vert = 0
      current_angle = 0

      directions.each do |direction|
        next if direction.nil? || direction[0].nil?

        amt = direction[1]

        case direction[0]
        when 'E'
          horz += amt
        when 'N'
          vert += amt
        when 'W'
          horz -= amt
        when 'S'
          vert -= amt
        when 'R'
          current_angle = (current_angle - amt) % 360
        when 'L'
          current_angle = (current_angle + amt) % 360
        when 'F'
          case angle_to_dir(current_angle)
          when 'E'
            horz += amt
          when 'N'
            vert += amt
          when 'W'
            horz -= amt
          when 'S'
            vert -= amt
          end
        else
          binding.pry
          raise ArgumentError, 'bad direction'
        end
      end
      horz.abs + vert.abs
    end

    def angle_to_dir(angle)
      case angle
      when 0
        'E'
      when 90
        'N'
      when 180
        'W'
      when 270
        'S'
      else
        raise ArgumentError, 'bad angle'
      end
    end

    # part 2 -------------------------------
    def manhattan_distance(file_path)
      values = IO.readlines(file_path, chomp: true).map(&:to_s)
      directions = values.map { |s| [s[0], s[1..-1].to_i] }
      wp_compute_distance(directions)
    end

    def wp_compute_distance(directions)
      wp = [10, 1]
      ship = [0, 0]

      directions.each do |direction|
        next if direction.nil? || direction[0].nil?

        amt = direction[1]

        case direction[0]
        when 'E'
          wp[0] += amt
        when 'N'
          wp[1] += amt
        when 'W'
          wp[0] -= amt
        when 'S'
          wp[1] -= amt
        when 'R'
          wp = rotate_wp(wp, amt * -1)
        when 'L'
          wp = rotate_wp(wp, amt)
        when 'F'
          ship[0] += (amt * wp[0])
          ship[1] += (amt * wp[1])
        else
          raise ArgumentError, 'bad direction'
        end
      end

      ship[0].abs + ship[1].abs
    end

    def rotate_wp(wp, degrees)
      x = wp[0]
      y = wp[1]

      radians = degrees * Math::PI / 180
      c = Math.cos(radians)
      s = Math.sin(radians)
      [(x * c - y * s).round, (y * c + x * s).round]
    end
  end
end
