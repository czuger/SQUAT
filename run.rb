require_relative 'lib/character'
require_relative 'lib/party'
require 'dungeon'

class Run

  def initialize
    @dungeon = Dungeon.new( 8 )
    @dungeon.generate
  end

  def start
    party = Party.new( @dungeon, 8 )

    1.upto(20) do
      party.choose_direction
      puts '*'*20
    end
  end

end

Run.new.start