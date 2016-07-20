class Pawn < Piece

  def initialize(pos, color, board)
    super
    @moved = false
  end

  def symbol
    color == :black ? " \u265F " : " \u2659 "
  end

  def get_moves
    opponent_color = @color == :black ? :white : :black
    multiplier = @color == :black ? 1 : -1
    all_moves = []
    one_forward = (pos.first + (1 * multiplier))
    two_forward = (pos.first + (2 * multiplier))

    if @board.in_bounds?([one_forward, pos.last]) &&
      @board[one_forward, pos.last].color == :null &&
      all_moves << [one_forward, pos.last]
    end

    if @moved == false &&
      @board[one_forward, pos.last].color == :null &&
      @board[two_forward, pos.last].color == :null
      all_moves << [two_forward, pos.last]
    end

    [-1, 1].each do | col_chg |
      new_col = pos.last + col_chg
      if @board.in_bounds?([one_forward, new_col]) &&
        @board[one_forward, new_col].color == opponent_color
        all_moves << [one_forward, new_col]
      end
    end
    all_moves
  end

  def set_moved
    @moved = true
  end
end
