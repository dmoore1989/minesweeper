require_relative 'Board'

class Game
  def initialize
    @board = Board.new
  end

  def play
    until over?
      input = get_move
      until valid_move?(input)
        puts "Invalid move, please retry."
        input = get_move
      end

      if input.include?("f")
        @board[input.last].toggle_flag
      else
        @board[input.last].####
      end


    end
  end

  def get_move
    puts "Please enter your move. Type f before the position to flag or unflag"
    move = gets.chomp
    move.scan("f") + move.scan(/\d/)[0, 2].map(&:to_i).to_a
  end

  def valid_move?(input)
    input.uniq!
    if input.length == 2
      input.last.length == 2
    else
      input.last.length == 2
    end
  end
end
