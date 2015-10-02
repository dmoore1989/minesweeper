class Tile
  attr_accessor :value, :flagged, :state

  def initialize
    @value = nil
    @flagged = false
    @state = :hidden
  end

  def reveal
    @state = :revealed
  end


end
