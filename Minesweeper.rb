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

    end
  end

  def get_move
    puts "Please enter your move. Type f before the position to flag"
    move = gets.chomp
    move.scan("f") + move.scan(/\d/)[0, 2].map(&:to_i)
  end

  def valid_move?(input)



  end
end
