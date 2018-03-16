class Party

  def initialize
    @members = 1.upto(4).map{ |c| Character.generate }
    @party_disagree = false
  end

  def will_checks
    @party_disagree = false
    more_willing_characters = @members
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
      if @party_disagree
        puts "#{more_willing_characters.first.name} had the last word ... "
      else
        puts "#{more_willing_characters.first.name} knows where to go and has choosed ... "
      end
    else
      @party_disagree = true
      puts "#{more_willing_characters.map{ |e| e.name }.join( ', ')} disagree ... "
    end
    more_willing_characters
  end

end