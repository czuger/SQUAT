class Party

  def initialize( dungeon )
    @members = 1.upto(4).map{ |c| Character.generate }
    @party_disagree = false
    @dungeon = dungeon
  end

  def will_checks
    @party_disagree = false
    more_willing_characters = @members
    more_willing_characters.each{ |m| m.choose_direction!( @dungeon.available_directions ) }
    while more_willing_characters.count > 1 do
      more_willing_characters = will_check( more_willing_characters )
    end
  end

  private

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
      names = more_willing_characters.map{ |e| e.name }.join( ', ')
      directions = more_willing_characters.map{ |e| e.name + ' wants to go ' + e.chosen_direction.to_s }.join( ', ')
      puts "#{names} disagree. #{directions}"
    end
    more_willing_characters
  end

  def comma_comma_and( strings )
    last_string = strings.pop
    ( strings.empty? ? '' : strings.join( ', ' ) ) + 'and ' + last_string
  end

end