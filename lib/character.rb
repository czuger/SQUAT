require 'hazard'
require_relative 'name'
require_relative 'roll'

class Character

  attr_reader :name, :mem, :vol, :last_will_score, :chosen_direction

  def initialize( name, mem, vol, path_finding )
    @name = name
    @mem = mem
    @vol = vol
    @path_finding = path_finding
    @last_will_score = nil
    @chosen_direction = nil
  end

  def self.generate
    Character.new( Name.get, Hazard.r3d6, Hazard.r3d6, Hazard.d6 )
  end

  def will_roll
    r = Roll.new( 0, @vol )
    @last_will_score = r.score
    @last_will_score += 10 if r.critical_success?
    @last_will_score -= 10 if r.critical_failure?
    @last_will_score
  end

  def choose_direction!( directions )
    @chosen_direction = directions.sample
    a = nil
  end

end