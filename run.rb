require_relative 'lib/character'
require_relative 'lib/party'
require 'dungeon'

class Run

  def initialize
    @dungeon = Dungeon.new( 8 )
    @dungeon.generate
  end

  def start
    party = Party.new( @dungeon, 4 )
    party.walk_in_dungeon
  end

end

Run.new.start