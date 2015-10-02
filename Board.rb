require_relative 'Tile'

class Board
  BOARD_SIZE = 9
  MINES = 10
  MOVES =[[1,0], [1,1], [0,1], [-1,0], [-1,-1], [0,-1], [1,-1], [-1,1]]

  def initialize
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) {Tile.new}}
    place_mines
    place_numbers
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
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

  def place_numbers
    @grid.each.with_index do |row, i|
      row.each.with_index do |tile, j|
        adjacent_mines = count_mines([i, j])
        unless tile.value == :M || adjacent_mines == 0
          tile.value =  adjacent_mines #Should this be an int?
        end
      end
    end
  end

  def check_valid_neighbors(position)
    moves = MOVES.map do |move|
      [move.first + position.first, move.last + position.last]
    end
    moves.select{ |move| move.all? { |pos| pos.between?(0, BOARD_SIZE - 1) }}
  end

  def count_mines(position)
    valid_moves = check_valid_neighbors(position)
    counter = 0

    valid_moves.each do |move|
      counter += 1 if self[move].value == :M
    end
    counter
  end



end
