require_relative 'Tile'

class Board
  BOARD_SIZE = 9
  MINES = 10
  MOVES =[[1,0], [1,1], [0,1], [-1,0], [-1,-1], [0,-1], [1,-1], [-1,1]]

  def initialize
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) {Tile.new}}
    place_mines
  end

  def place_mines
    mine_count = 0
    until mine_count == MINES
      mine_tile = @grid.sample.sample
      unless mine_tile.value == :M
        mine_tile.value = :M
        mine_count += 1
      end
    end
  end

  def check_valid_neighbors(position)
    moves = MOVES.map do |move|
      [move.first + position.first, move.last + position.last]
    end
    moves.select{ |move| move.all? { |pos| pos.between?(0, BOARD_SIZE - 1) }}
  end

end
