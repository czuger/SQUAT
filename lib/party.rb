require 'dungeon'
require_relative 'character'

class Party

  def initialize( dungeon, party_size )
    @members = 1.upto(party_size).map{ |c| Character.generate }
    @party_disagree = false
    @dungeon = dungeon
  end

  def choose_direction
    @members.each{ |m| m.choose_direction!( @dungeon.available_directions ) }
    chosen_directions = @members.map{ |m| m.chosen_direction }.uniq
    if chosen_directions.count == 1
      puts "Everybody agree to go #{chosen_directions.first}"
    else
      will_checks
    end
  end

  private

  def will_checks
    @party_disagree = false
    more_willing_characters = @members
    while more_willing_characters.count > 1 do
      more_willing_characters = will_check( more_willing_characters )
    end
  end

  def will_check( more_willing_characters )
    max_will = 0
    more_willing_characters.each do |m|
      will_score = m.will_roll
      max_will = [ max_will, will_score ].max
    end

    more_willing_characters = more_willing_characters.select{ |c| c.last_will_score == max_will }
    if more_willing_characters.count == 1
      c = more_willing_characters.first
      if @party_disagree
        puts "#{c.name} had the last word. Party will go #{c.chosen_direction}"
      else
        puts "#{c.name} knows where to go and has choosed #{c.chosen_direction}"
      end
    else
      @party_disagree = true
      names = comma_comma_and( more_willing_characters.map{ |e| e.name } )
      directions = comma_comma_and( more_willing_characters.map{ |e| e.name + ' wants to go ' + e.chosen_direction.to_s } )
      puts "#{names} disagree. #{directions}"
    end
    more_willing_characters
  end

  def comma_comma_and( strings )
    raise 'strings should be an array' unless strings.is_a? Array
    return '' if strings.empty?
    return strings.first if strings.count == 1
    last_string = strings.pop
    ( strings.empty? ? '' : strings.join( ', ' ) ) + ' and ' + last_string
  end

end