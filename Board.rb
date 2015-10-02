require_relative 'Tile'

class Board
  BOARD_SIZE = 8
  MINES = 10

  def initialize
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) {Tile.new}}
    place_bombs
  end

  def place_bombs
    mine_count = 0
    until mine_count == MINES
      mine_tile = @grid.sample.sample
      unless mine_tile.value == :M
        mine_tile.value = :M
        mine_count += 1
      end
    end
  end

end
