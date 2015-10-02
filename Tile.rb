class Tile
  attr_accessor :value, :flagged

  def initialize
    @value = nil
    @flagged = false
    @state = :hidden
  end

  def reveal
    @state = :revealed
  end


end
