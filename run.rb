require_relative 'lib/character'
require_relative 'lib/party'
require 'dungeon'

class Run

  def initialize
    @dungeon = Dungeon.new( 4 )
  end

  def start
    party = Party.new
    party.will_checks
  end

end

Run.new.start