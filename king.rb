require_relative "stepable"

class King < Piece
  include Stepable

  MOVE_OPTIONS = [
    [1,0], [-1, 0], [0, 1], [0, -1],
    [1, -1], [1, 1], [-1, -1], [-1, 1]
  ]

  def initialize(pos, color, board)
    super
  end

  def symbol
    color == :black ? " \u265A " : " \u2654 "
  end

  def get_moves
    get_potential_moves(MOVE_OPTIONS)
  end
end
