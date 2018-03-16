require_relative 'lib/character'
require 'dungeon'

class Run

  def initialize
    @dungeon = Dungeon.new( 4 )
  end

  def start
    characters = 1.upto(4).map{ |c| Character.generate }
    p characters
  end

end

Run.new.start