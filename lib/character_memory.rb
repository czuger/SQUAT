class CharacterMemory

  def initialize
    @visited_rooms = {}
  end

  def filter_directions( room, directions )
    vr = @visited_rooms[ room ]
    return directions - vr if vr
    directions
  end

  def remember_direction( room, direction )
    @visited_rooms[ room ] ||= []
    @visited_rooms[ room ] << direction
  end

end