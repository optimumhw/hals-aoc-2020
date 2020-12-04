require_relative '../passport_validator'

describe 'PassportValidator#count_valid_passports' do
  context 'when given the sample input' do
    it 'counts the number of valid passports' do
      expect(
        PassportValidator.count_valid_passports('spec/sample_input.txt')
      ).to eq(2)
    end
  end

  context 'when given my part1 input' do
    it 'counts the number of valid passports' do
      expect(
        PassportValidator.count_valid_passports('spec/puzzle_input.txt')
      ).to eq(264)
    end
  end

  # part2 --------------

  # year validation
  # byr (Birth Year) - four digits; at least 1920 and at most 2002.
  # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  context 'when given a year string and min/max' do
    it 'validates the year' do
      expect(
        PassportValidator.validate_year?('1930', 1920, 2002)
      ).to eq(true)
    end
  end

  context 'when given a year string and min/max' do
    it 'validates the year' do
      expect(
        PassportValidator.validate_year?('1919', 1920, 2002)
      ).to eq(false)
    end
  end

  context 'when given a year string and min/max' do
    it 'validates the year' do
      expect(
        PassportValidator.validate_year?('2003', 1920, 2002)
      ).to eq(false)
    end
  end

  context 'when given a too-short year string and min/max' do
    it 'validates the year' do
      expect(
        PassportValidator.validate_year?('190', 180, 200)
      ).to eq(false)
    end
  end

  context 'when given a too-short year string and min/max' do
    it 'validates the year' do
      expect(
        PassportValidator.validate_year?('alp', 1800, 2000)
      ).to eq(false)
    end
  end

  context 'when given a too-short year string and min/max' do
    it 'validates the year' do
      expect(
        PassportValidator.validate_year?(nil, 1800, 2000)
      ).to eq(false)
    end
  end

  # height validation
  # hgt (Height) - a number followed by either cm or in:
  # If cm, the number must be at least 150 and at most 193.
  # If in, the number must be at least 59 and at most 76.

  context 'when given a height' do
    it 'validates the height' do
      expect(
        PassportValidator.validate_hgt?('180cm')
      ).to eq(true)
    end
  end

  context 'when given a height' do
    it 'validates the height' do
      expect(
        PassportValidator.validate_hgt?('cm180')
      ).to eq(false)
    end
  end

  context 'when given a height' do
    it 'validates the height' do
      expect(
        PassportValidator.validate_hgt?('149cm')
      ).to eq(false)
    end
  end

  context 'when given a height' do
    it 'validates the height' do
      expect(
        PassportValidator.validate_hgt?('194cm')
      ).to eq(false)
    end
  end

  context 'when given a height' do
    it 'validates the height' do
      expect(
        PassportValidator.validate_hgt?('')
      ).to eq(false)
    end
  end

  context 'when given a height' do
    it 'validates the height' do
      expect(
        PassportValidator.validate_hgt?('193cm')
      ).to eq(true)
    end
  end

  context 'when given a height' do
    it 'validates the height' do
      expect(
        PassportValidator.validate_hgt?('149cm')
      ).to eq(false)
    end
  end

  # ------------59-76---------------

  context 'when given a height' do
    it 'validates the height' do
      expect(
        PassportValidator.validate_hgt?('58in')
      ).to eq(false)
    end
  end

  context 'when given a height' do
    it 'validates the height' do
      expect(
        PassportValidator.validate_hgt?('59in')
      ).to eq(true)
    end
  end

  context 'when given a height' do
    it 'validates the height' do
      expect(
        PassportValidator.validate_hgt?('76in')
      ).to eq(true)
    end
  end

  context 'when given a height' do
    it 'validates the height' do
      expect(
        PassportValidator.validate_hgt?('77in')
      ).to eq(false)
    end
  end

  context 'when given a height' do
    it 'validates the height' do
      expect(
        PassportValidator.validate_hgt?('123yd')
      ).to eq(false)
    end
  end

  # hair color validation
  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  context 'when given a hair color' do
    it 'validates the hair color' do
      expect(
        PassportValidator.validate_hcl?('#abc123')
      ).to eq(true)
    end
  end

  context 'when given a hair color' do
    it 'validates the hair color' do
      expect(
        PassportValidator.validate_hcl?('#abc1234')
      ).to eq(false)
    end
  end

  context 'when given a hair color' do
    it 'validates the hair color' do
      expect(
        PassportValidator.validate_hcl?('##ffff')
      ).to eq(false)
    end
  end

  context 'when given a hair color' do
    it 'validates the hair color' do
      expect(
        PassportValidator.validate_hcl?('#abcg123')
      ).to eq(false)
    end
  end

  context 'when given a hair color' do
    it 'validates the hair color' do
      expect(
        PassportValidator.validate_hcl?('abcg123')
      ).to eq(false)
    end
  end

  context 'when given a hair color' do
    it 'validates the hair color' do
      expect(
        PassportValidator.validate_hcl?('##cg123')
      ).to eq(false)
    end
  end

  # eye color validation
  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  context 'when given a eye color' do
    it 'validates the eye color' do
      expect(
        PassportValidator.validate_ecl?('blu')
      ).to eq(true)
    end
  end

  context 'when given a eye color' do
    it 'validates the eye color' do
      expect(
        PassportValidator.validate_ecl?('brn')
      ).to eq(true)
    end
  end
  context 'when given a eye color' do
    it 'validates the eye color' do
      expect(
        PassportValidator.validate_ecl?('gry')
      ).to eq(true)
    end
  end
  context 'when given a eye color' do
    it 'validates the eye color' do
      expect(
        PassportValidator.validate_ecl?('grn')
      ).to eq(true)
    end
  end
  context 'when given a eye color' do
    it 'validates the eye color' do
      expect(
        PassportValidator.validate_ecl?('hzl')
      ).to eq(true)
    end
  end
  context 'when given a eye color' do
    it 'validates the eye color' do
      expect(
        PassportValidator.validate_ecl?('oth')
      ).to eq(true)
    end
  end

  context 'when given a eye color' do
    it 'validates the eye color' do
      expect(
        PassportValidator.validate_ecl?('bluu')
      ).to eq(false)
    end
  end

  context 'when given a eye color' do
    it 'validates the eye color' do
      expect(
        PassportValidator.validate_ecl?('')
      ).to eq(false)
    end
  end

  # PIDs
  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  context 'when given a pid' do
    it 'validates the pid' do
      expect(
        PassportValidator.validate_pid?('')
      ).to eq(false)
    end
  end

  context 'when given a pid' do
    it 'validates the pid' do
      expect(
        PassportValidator.validate_pid?('123123123')
      ).to eq(true)
    end
  end

  context 'when given a pid' do
    it 'validates the pid' do
      expect(
        PassportValidator.validate_pid?('1231231235')
      ).to eq(false)
    end
  end

  context 'when given a pid' do
    it 'validates the pid' do
      expect(
        PassportValidator.validate_pid?('12312312')
      ).to eq(false)
    end
  end

  context 'when given a pid' do
    it 'validates the pid' do
      expect(
        PassportValidator.validate_pid?('123a23123')
      ).to eq(false)
    end
  end

  # Test whole blob
  context 'when given a good blob' do
    blob = 'pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980 hcl:#623a2f'
    it 'returns true' do
      expect(
        PassportValidator.super_validate?(blob)
      ).to eq(true)
    end
  end

  context 'when given a bad blob (hcl missing #)' do
    blob = 'hcl:dab227 iyr:2012 ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277'
    it 'returns false' do
      expect(
        PassportValidator.super_validate?(blob)
      ).to eq(false)
    end
  end

  # valid passport counting

  context 'when given the p2 invalid sample input' do
    it 'counts the number of valid passports' do
      expect(
        PassportValidator.count_super_valid_passports('spec/part2_invalid_samples.txt')
      ).to eq(0)
    end
  end

  context 'when given the p2 valid sample input' do
    it 'counts the number of valid passports' do
      expect(
        PassportValidator.count_super_valid_passports('spec/part2_valid_examples.txt')
      ).to eq(4)
    end
  end

  context 'when given my part1 input' do
    it 'counts the number of valid passports' do
      expect(
        PassportValidator.count_super_valid_passports('spec/puzzle_input.txt')
      ).to eq(224)
    end
  end
end
