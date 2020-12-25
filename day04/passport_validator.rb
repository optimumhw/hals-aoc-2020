require 'pry'
require 'benchmark'
require 'json'

module PassportValidator
  class << self

    OPS = %w( byr iyr eyr hgt hcl ecl pid cid )

    def count_valid_passports(file_path)
      file_data = File.read(file_path)

      file_data
        .split(/\n{2,}/)
        .map { |blob| blob.split(/\n/) }
        .map { |passport| passport.join(' ') }
        .select { |passport| validate?(passport) }
        .size
    end

    def validate?(passport_blob)
      passport = transform_blob_to_template(passport_blob)

     !OPS.any?{ passport.public_send( _1).nil? }

    end

    def count_super_valid_passports(file_path)
      file_data = File.read(file_path)

      file_data
        .split(/\n{2,}/)
        .map { |blob| blob.split(/\n/) }
        .map { |passport| passport.join(' ') }
        .select { |passport| super_validate?(passport) }.size
    end

    def transform_blob_to_template(passport_blob)
      passport_pieces = passport_blob.split.map { |kv| kv.split(':') }



      template = OpenStruct.new( **OPS.map{ [_1.to_sym, nil] }.to_h )

      passport_pieces.each do |piece|
        case piece[0]
        when 'byr'
          template.byr = piece[1]
        when 'iyr'
          template.iyr = piece[1]
        when 'eyr'
          template.eyr = piece[1]
        when 'hgt'
          template.hgt = piece[1]
        when 'hcl'
          template.hcl = piece[1]
        when 'ecl'
          template.ecl = piece[1]
        when 'pid'
          template.pid = piece[1]
        when 'cid'
          template.cid = piece[1]
        else
          pp "error: #{piece[0]} ????"
        end
      end

      template
    end

    def super_validate?(passport_blob)
      passport = transform_blob_to_template(passport_blob)

      valid = true

      # byr (Birth Year) - four digits; at least 1920 and at most 2002.
      valid = false unless validate_year?(passport.byr, 1920, 2002)

      # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
      valid = false unless validate_year?(passport.iyr, 2010, 2020)

      # eyr (Expiration Year) - four digits; at least 2020 and at most 2030
      valid = false unless validate_year?(passport.eyr, 2020, 2030)

      valid = false unless validate_hgt?(passport.hgt)

      valid = false unless validate_hcl?(passport.hcl)

      valid = false unless validate_ecl?(passport.ecl)

      valid = false unless validate_pid?(passport.pid)

      # cid (Country ID) - ignored, missing or not.
      # return false if passport.cid.nil?

      valid
    end

    def validate_year?(str, min, max)
      return false if str.nil? || str.match(/^[0-9]{4}$/).nil?

      begin
        year = Integer(str)
        year >= min && year <= max
      rescue StandardError
        pp "oooopssss....#{str}"
        false
      end
    end

    # hgt (Height) - a number followed by either cm or in:
    # If cm, the number must be at least 150 and at most 193.
    # If in, the number must be at least 59 and at most 76.
    def validate_hgt?(hgt)
      return false if hgt.nil?

      pieces = /(\d+)(cm|in)/.match(hgt)

      return false if pieces.nil?

      begin
        size = Integer(pieces[1])
      rescue StandardError
        false
      end

      case pieces[2]
      when 'in'
        size >= 59 && size <= 76
      when 'cm'
        size >= 150 && size <= 193
      else
        false
      end
    end

    # hair color validation
    # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    def validate_hcl?(hcl)
      return false if hcl.nil?

      !/^#[a-f|0-9]{6}$/.match(hcl).nil?
    end

    # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    def validate_ecl?(ecl)
      return false if ecl.nil?
      return false if ecl.length > 3

      !/^amb|blu|brn|gry|grn|hzl|oth$/.match(ecl).nil?
    end

    # PIDs
    # pid (Passport ID) - a nine-digit number, including leading zeroes.
    def validate_pid?(pid)
      return false if pid.nil?

      !/^[0-9]{9}$/.match(pid).nil?
    end
  end
end
