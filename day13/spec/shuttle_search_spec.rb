# frozen_string_literal: true

require_relative '../shuttle_search'

describe 'ShuttleSearch#distance' do
  context 'when given the sample' do
    it 'computes id * min' do
      expect(
        ShuttleSearch.compute_product('spec/sample_input.txt')
      ).to eq(295)
    end
  end

  context 'when given the puzzle input' do
    it 'computes id * min' do
      expect(
        ShuttleSearch.compute_product('spec/puzzle_input.txt')
      ).to eq(1915)
    end
  end


  # part2 ========================
  context 'when relatively prime' do
    it ' gcd returns 1' do
      expect( ShuttleSearch.gcd( 4301, 840 )).to eq(1)
      expect( ShuttleSearch.gcd( 840, 4301 )).to eq(1)
      expect( ShuttleSearch.relatively_prime?( 840, 4301 )).to eq(true)
    end
  end

  context 'when a equals b' do
    it ' gcd returns b' do
      expect( ShuttleSearch.gcd( 10, 10 )).to eq(10)
      expect( ShuttleSearch.relatively_prime?( 10, 10 )).to eq(false)
    end
  end

  context 'when gcd is 5' do
    it ' gcd returns 5' do
      expect( ShuttleSearch.gcd( 10, 15 )).to eq(5)
      expect( ShuttleSearch.relatively_prime?( 10, 5 )).to eq(false)
    end
  end

  context 'when given two integers' do
    it 'bezout returns the bezout coefficients and gcd' do
      expect( ShuttleSearch.bezout( 24, 18 )).to eq({"gcd" => 6, "x" => 1, "y" => -1})
    end
  end

  context 'when given 24 and 18' do
    r = ShuttleSearch.bezout( 24, 18 )
    it 'bezout returns the bezout coefficients and gcd' do
      expect( 24 * r["x"] + 18 * r["y"] ).to eq( r["gcd"])
    end
  end

  context 'when given 161 and 28' do
    r = ShuttleSearch.bezout( 161, 28 )
    it 'bezout returns the bezout coefficients and gcd' do
      expect( 161 * r["x"] + 28 * r["y"] ).to eq( r["gcd"])
    end
  end

  context 'when given integers 195 and 154' do
    a = 195
    b = 154
    r = ShuttleSearch.bezout( a, b )
    it 'returns the bezout coefficients and gcd' do
      expect( r["gcd"] => 1, r["x"] => -15, r["y"] => 19 )
      expect( a * r["x"] + b * r["y"] ).to eq( r["gcd"])
    end
  end

  context 'when asked for the inverse of two integers NOT relatively prime' do
    a = 5
    b = 10

    it 'raises an exception' do
      expect{ ShuttleSearch.multInverse!( a, b ) }.to raise_error()
    end
  end

  context 'when asked for the inverse of 11 mod 26' do
    a = 11
    b = 26
    it 'returns 19' do
      expect( ShuttleSearch.multInverse!( a, b ) ).to eq(19)
    end
  end

  context 'when asked for the inverse of 33 mod 70' do
    a = 33
    b = 70
    it 'returns 19' do
      expect( ShuttleSearch.multInverse!( a, b ) ).to eq(17)
    end
  end

  context 'when given an array of numbers all rel prime' do
    it 'returns true' do
      expect(
        ShuttleSearch.all_relatively_prime?( [2,3,5,7,11] )
        ).to eq(true)
    end
  end

  context 'when given an array of numbers NOT all rel prime' do
    it 'returns false' do
      expect(
        ShuttleSearch.all_relatively_prime?( [2,3,5,7,10,11] )
        ).to eq(false)
    end
  end

  context 'when asked for the first time from invalid array' do
    it 'raises an exception' do
      expect{ ShuttleSearch.compute_first_time!( [[2,0],[3,6],[10,12]] ) }.to raise_error()
    end
  end

  context 'when asked for the inverse of 70 mod 3' do
    a = 70
    b = 3
    it 'returns 1' do
      expect( ShuttleSearch.multInverse!( a, b ) ).to eq(1)
    end
  end

  context 'when asked for the inverse of 30 mod 7' do
    a = 30
    b = 7
    it 'returns 1' do
      expect( ShuttleSearch.multInverse!( a, b ) ).to eq(4)
    end
  end

  context 'when asked for the inverse of 21 mod 10' do
    a = 21
    b = 10
    it 'returns 1' do
      expect( ShuttleSearch.multInverse!( a, b ) ).to eq(1)
    end
  end

  context 'when asked for the first time from valid array' do
    it 'computes the number' do
      expect( ShuttleSearch.compute_first_time!( [[3,2],[7,3],[10,9]] ) ).to eq(59)
    end
  end

  context 'when asked for the first time' do
    it 'computes fist time' do
      expect(
        ShuttleSearch.compute_first_time_from_file('spec/sample_input.txt')
      ).to eq(1068781)
    end
  end

  context 'when asked for the first time' do
    it 'computes fist time' do
      expect(
        ShuttleSearch.compute_first_time_from_file('spec/puzzle_input.txt')
      ).to eq(294354277694107)
    end
  end

end
  
