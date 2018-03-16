require 'dungeon'
require_relative 'character'

class Party

  attr_reader :chosen_direction

  def initialize( dungeon, party_size )
    @members = 1.upto(party_size).map{ |c| Character.generate }
    @party_disagree = false
    @dungeon = dungeon
    @chosen_direction = nil
  end

  def walk_in_dungeon
    while @dungeon.current_room.content != 'H' do
      choose_direction
      @dungeon.set_next_room( @chosen_direction )
      content = @dungeon.current_room.content ? @dungeon.current_room.content : 'nothing'
      puts "Party arive into room #{@dungeon.current_room.room_id}. Room contains #{@dungeon.current_room.content}"
      puts
      puts '*'*40
      puts
    end
    puts 'Party find the treasure'
  end

  def choose_direction
    directions = @dungeon.available_directions
    puts "Available directions are #{directions}"
    @members.each{ |m| m.choose_direction!( directions ) }
    chosen_directions = @members.map{ |m| m.chosen_direction }.uniq
    if chosen_directions.count == 1
      puts "Everybody agree to go #{chosen_directions.first}"
      @chosen_direction = chosen_directions.first
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
      @chosen_direction = c.chosen_direction
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