require 'hazard'
require_relative 'name'

class Character

  attr_reader :name, :mem, :vol

  def initialize( name, mem, vol )
    @name = name
    @mem = mem
    @vol = vol
  end

  def self.generate
    Character.new( Name.get, Hazard.r3d6, Hazard.r3d6 )
  end

end