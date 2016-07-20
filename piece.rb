class Piece
  attr_reader :color, :board

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def valid_move?(pos)
    @board.in_bounds?(pos) && @board[*pos].color != self.color
  end

  def move(new_pos)
    @pos = new_pos
  end

  def pos
    @pos
  end

  def inspect
   "#{color.to_s} #{self.class.to_s} at #{pos}"
 end
end
