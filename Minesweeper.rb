require_relative 'Board'
require 'byebug'

class Game

  attr_accessor :board

  def initialize
    @board = Board.new
    @game_state = nil
  end

  def play
    until @game_state
      @board.display
      input = get_move
      until valid_move?(input)
        puts "Invalid move, please retry."
        input = get_move
      end

      if input.include?("f")
        @board[input.last].toggle_flag
      else
        take_move(input.last)
      end

      @gane_state = :win if @board.hidden_count == Board::MINES

    end

    if @game_state == :win
      @board.reveal_all
      @board.display
      puts "You Win!!!!"
    else
      @board.reveal_all
      @board.display
      puts "You Lose"
    end


  end

  def take_move(position)

    if self.board[position].value == :M
      @game_state = :lose
    else
      @board[position].reveal
      @board.reveal_white_space(position)
    end
  end


  def get_move
    puts "Please enter your move. Type f before the position to flag or unflag"
    move = gets.chomp.downcase
    move.scan("f") << move.scan(/\d/)[0, 2].map(&:to_i)
  end

  def valid_move?(input)
    # byebug
    input.uniq!
    return false if input.last.length != 2
    return false if input.first != "f" && @board[input.last].flagged

    input.last.length == 2 && @board[input.last].state == :hidden

  end
end
