require_relative 'test_helper'

class TestParty < Minitest::Test

  def setup
    @dungeon = Dungeon.new( 4 )
    @dungeon.generate
    @party = Party.new( @dungeon, 4 )
  end

  def test_comma_comma_and_with_3_names_party
    assert_equal 'Han, Luke and Yoda', @party.send( 'comma_comma_and', %w( Han Luke Yoda ) )
  end

  def test_comma_comma_and_with_2_names_party
    assert_equal 'Han and Luke', @party.send( 'comma_comma_and', %w( Han Luke ) )
  end

  def test_comma_comma_and_with_1_names_party
    p @party.send( 'comma_comma_and', %w( Han ) )
    assert_equal  'Han', @party.send( 'comma_comma_and', %w( Han ) )
  end

end