class Player

  attr_reader :name, :color

  def initialize(name)
    @name = name
    @color = nil
  end

  def set_color(color)
    @color = color
  end

  def get_move(display)
    begin
      display_msg = "#{@name} pick your piece."
      selected_square = display.get_square(display_msg)
      selected_piece = display.board[*selected_square]
      unless selected_piece.color == @color
        raise ColorError
      end

      #TODO send feedback to board to light up seleted square
      # and add a variable "e" for the error to puts out

      available_moves = selected_piece.get_moves
      display_msg = "Where would you like to move #{selected_piece.class}?"
      display.reset_cursor(selected_square)
      select_dest_sq = display.get_square(display_msg)
      unless available_moves.include?(select_dest_sq)
        raise InvalidMoveError
      end
    rescue InvalidMoveError => e
      puts e.msg
      sleep 1
      retry
    rescue ColorError => e
      puts e.msg
      sleep 1
      retry
    end
    return selected_square, select_dest_sq
  end

  def set_color(color)
    @color = color
  end
end
