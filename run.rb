require_relative 'lib/character'
require_relative 'lib/party'
require 'dungeon'

class Run

  def initialize
    @dungeon = Dungeon.new( 4 )
    @dungeon.generate
  end

  def start
    1.upto(10) do
      party = Party.new( @dungeon )
      party.will_checks
      puts '*'*20
    end
  end

end

Run.new.start