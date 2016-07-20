require_relative "stepable"

class Knight < Piece
  include Stepable

  MOVE_OPTIONS = [
    [2,1], [2, -1], [-2, 1], [-2, -1],
    [1, 2], [-1, 2], [1, -2], [-1, -2]
  ]

  def initialize(pos, color, board)
    super
  end

  def symbol
    color == :black ? " \u265E " : " \u2658 "
  end

  def get_moves
    get_potential_moves(MOVE_OPTIONS)
  end

end
