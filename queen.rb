require_relative "slideable"

class Queen < Piece
  include Slideable

  MOVE_OPTIONS = [:up_right, :up_left, :down_left, :down_right, :up, :right, :down, :left]

  def initialize(pos, color, board)
    super
  end

  def symbol
    color == :black ? " \u265B " : " \u2655 "
  end

  def get_moves
    all_moves = []
    MOVE_OPTIONS.each do | direction |
      all_moves.concat(get_slide_moves(direction, pos))
    end
    all_moves
  end

end
