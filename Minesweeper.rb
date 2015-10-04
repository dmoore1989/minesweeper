require 'yaml'
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


      if input == "save"
        save_f
      elsif input == "load"
        load_f
      elsif input.include?("f")
        @board[input.last].toggle_flag
      else
        take_move(input.last)
      end

      @game_state = :win if @board.hidden_count == Board::MINES

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
    puts "Type save to save your game, load to load your game"
    move = gets.chomp.downcase
    return move if move == "save" || move == "load"
    move.scan("f") << move.scan(/\d/)[0, 2].map(&:to_i)
  end

  def valid_move?(input)
    # byebug
    return true if input == "save" || input == "load"
    input.uniq!

    return false if input.last.length != 2
    return false if input.first != "f" && @board[input.last].flagged

    input.last.length == 2 && @board[input.last].state == :hidden

  end

  def save_f
    save_file = self.to_yaml
    File.open("minesweeper.txt", "w") do |f|
      f.puts save_file
    end
  end

  def load_f
    load_file = File.read("minesweeper.txt")
    YAML.load(load_file).play
  end
end
