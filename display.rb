require 'colorize'
require_relative 'board'
require_relative "cursorable"

class Display
  include Cursorable

  attr_reader :board, :cursor, :selected

  def initialize(board)
    @board = board
    @cursor = [0,0]
    @selected = false
    nil
  end

  def display_board
    puts "  | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | "
    puts "-----------------------------------"
    @board.rows.each_with_index do |row, r_idx|
      print "#{r_idx} |"
      row.each_with_index do | piece, c_idx |
        if [r_idx, c_idx] == @cursor
          print piece.symbol.colorize(:background => :cyan)
        elsif (c_idx + r_idx).odd?
          print piece.symbol.colorize(:background => :white)
        else
          print piece.symbol.colorize(:background => :light_white)
        end
        print "|"
      end
      print "\n"
    end
    puts "-----------------------------------"
    nil
  end

  def get_square(message)
    @selected = false
    until selected
      system("clear")
      display_board
      puts message
      input_result = get_input
      if input_result == "Selected"
        @selected = true
        return @cursor
      end
    end
  end

  def reset_cursor(pos)
    @cursor = pos
  end
end
