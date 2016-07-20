require_relative "slideable"

class Rook < Piece
  include Slideable

  MOVE_OPTIONS = [:up, :right, :down, :left]

  def initialize(pos, color, board)
    super
  end

  def symbol
    color == :black ? " \u265C " : " \u2656 "
  end

  def get_moves
    all_moves = []
    MOVE_OPTIONS.each do | direction |
      all_moves.concat(get_slide_moves(direction, pos))
    end
    all_moves
  end

end
