# coding: utf-8

require 'colorize'
require_relative 'Tile'
# require 'byebug'

class Board
  BOARD_SIZE = 9
  MINES = 10
  MOVES =[[1,0], [1,1], [0,1], [-1,0], [-1,-1], [0,-1], [1,-1], [-1,1]]
  COLORS = {
    :M => :red,
    1 => :blue,
    2 => :yellow,
    3 => :cyan,
    4 => :magenta,
    5 => :magenta,
    6 => :magenta,
    7 => :magenta,
    8 => :magenta
  }

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

  def hidden_count
    counter = 0
    @grid.each do |row|
      row.each do |tile|
        counter += 1 if tile.state == :hidden
      end
    end

    counter
  end

  def reveal_white_space(position)
    neighbors = check_valid_neighbors(position).map{|neighbor| self[neighbor] }
    neighbors.reject!{ |neighbor| neighbor.state == :revealed || neighbor.value == :M}
    neighbors.each do |neighbor|
      neighbor.reveal unless neighbor.flagged
      unless neighbor.value.is_a?(Integer)
        reveal_white_space(tile_position(neighbor))
      end
    end
    nil
  end

  def tile_position(tile)
    @grid.each.with_index do |row, i|
      row.each.with_index do |cell, j|
        return [i, j] if cell == tile
      end
    end
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

  def display
    system("clear")
    display_grid = @grid.map do |row|
      row.map do |tile|
        if tile.state == :revealed
          if tile.value.nil?
            " "
          else
            tile.value.to_s.colorize(COLORS[tile.value])
          end
        elsif tile.flagged
          "\u2691".colorize(:green)
        else
          "⬜"
        end
      end.join(" ") + "\n"
    end
    puts display_grid
  end


  def reveal_all
    @grid.each do |row|
      row.each do |tile|
        tile.reveal
      end
    end
  end

end
