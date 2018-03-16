class Check

  attr_reader :success, :critic, :score, :roll, :status

  def initialize( attribute, skill=0 )
    @attribute = attribute
    @skill = skill
  end

  def roll( difficulty=10, bonus=0 )
    @roll = Hazard.s2d10

    @score = @roll.result + @attribute + bonus + @skill
    @success = @score >= 10 + difficulty
    @critic = @roll.rolls[0] == @roll.rolls[1]

    @status = @success ? 'success' : 'failure'
    @status = ( @critic ? 'critical_' : '' ) + @status
    @status = @status.to_sym
  end

  def success?
    @success
  end

  def failure?
    !@success
  end

  def critical_success?
    @success && @critic
  end

  def critical_failure?
    !@success && @critic
  end

  def to_s
    [ ('critic' if @critic), @success ? 'success' : 'failure', @score ].compact.join( ' - ' )
  end

end