require 'hazard'
require_relative 'name'
require_relative 'check'
require_relative 'character_memory'

class Character

  attr_reader :name, :mem, :vol, :last_will_score, :chosen_direction
  @@characters_memory = CharacterMemory.new

  def initialize( name, mem, vol, path_finding )
    @name = Name.get

    @mem = Hazard.r3d6
    @vol = Hazard.r3d6
    @path_finding = Hazard.d6

    @will_check = Check.new( @vol, 0 )
    @path_finding_check = Check.new( @mem, @path_finding )

    @chosen_direction = nil
    @last_will_score = nil
    @path_finding_will_bonus = nil
  end

  def self.generate
    Character.new( Name.get, Hazard.r3d6, Hazard.r3d6, Hazard.d6 )
  end

  def will_roll
    @will_check.roll( 0, )
    @last_will_score = @will_check.score
    @last_will_score += 10 if @will_check.critic
    @last_will_score
  end

  def path_finding_check
    @path_finding_check.roll( 12 )
    @path_finding_will_bonus = 10 if @path_finding_check.critic
    @path_finding_check.success?
  end

  def choose_direction!( room, directions )
    if path_finding_check
      filtered_directions = @@characters_memory.filter_directions( room, directions )
    end
    puts "#{@name} remembers #{directions-filtered_directions}" if filtered_directions
    @chosen_direction = ( filtered_directions && !filtered_directions.empty? ? filtered_directions : directions ).sample
  end

  def remember_direction( room, direction )
    @@characters_memory.remember_direction( room, direction )
  end

end