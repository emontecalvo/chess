require_relative "null_piece"
require_relative "piece"
require_relative "bishop"
require_relative "king"
require_relative "knight"
require_relative "pawn"
require_relative "queen"
require_relative "rook"
require_relative "display"

class Board

  attr_reader :rows

  def initialize
    @rows = Array.new(8) { Array.new(8, NullPiece.instance) }
    populate_pieces
    nil
  end

  def populate_pieces
    # black pawns
    @rows[1].each_index do | c_idx |
      self[1, c_idx] = Pawn.new([1,c_idx], :black, self)
    end

    # black rooks
    [0, 7].each do | c_idx |
      self[0, c_idx] = Rook.new([0, c_idx], :black, self)
    end

    #black knights
    [1, 6].each do | c_idx |
      self[0, c_idx] = Knight.new([0, c_idx], :black, self)
    end

    #black bishops
    [2, 5].each do | c_idx |
      self[0, c_idx] = Bishop.new([0, c_idx], :black, self)
    end

    #black king
    self[0, 4] = King.new([0, 4], :black, self)

    #black queen
    self[0, 3] = Queen.new([0,3], :black, self)

    #white pawns
    @rows[6].each_index do | c_idx |
      self[6, c_idx] = Pawn.new([6,c_idx], :white, self)
    end

    # white rooks
    [0, 7].each do | c_idx |
      self[7, c_idx] = Rook.new([7, c_idx], :white, self)
    end

    # white knights
    [1, 6].each do | c_idx |
      self[7, c_idx] = Knight.new([7, c_idx], :white, self)
    end

    #white bishops
    [2, 5].each do | c_idx |
      self[7, c_idx] = Bishop.new([7, c_idx], :white, self)
    end

    #white king
    self[7, 4] = King.new([7, 4], :white, self)

    #white queen
    self[7, 3] = Queen.new([7,3], :white, self)
  end

  def [](*pos)
    x, y = pos
    @rows[x][y]
  end

  def []=(*pos, value)
    x, y = pos
    # byebug
    @rows[x][y] = value
  end

  def move_piece(from_pos, to_pos) # later color arg?
    piece_at_from_pos = self[*from_pos]
    piece_at_from_pos.move(to_pos)
    self[*to_pos] = piece_at_from_pos
    self[*from_pos] = NullPiece.instance
    if piece_at_from_pos.class == Pawn
      piece_at_from_pos.set_moved
    end
  end

  def check?(color)
    opponent_color = color == :white ? :black : :white
    king_pos = find_king(color)
    @rows.each do | row |
      row.each do | piece |
        if piece.color == opponent_color
          return true if piece.get_moves.include?(king_pos)
        end
      end
    end
    false
  end

  def checkmate?(color)
    king_pos = find_king(color)
    @rows.each_with_index do |row, ridx|
      row.each_with_index do |piece, pidx|
        if piece.color == color
          piece_moves = piece.get_moves
          piece_moves.each do |move|
            piece_at_target = self[*move]
            move_piece(piece.pos, move)
            if !check?(color)
              self[*move] = piece_at_target
              self[ridx, pidx] = piece
              piece.move([ridx, pidx])
              return false
            end
            self[*move] = piece_at_target
            self[ridx, pidx] = piece
            piece.move([ridx, pidx])
          end
        end
      end
    end
    true
  end

  def find_king(color)
    @rows.each_with_index do | row, r_idx |
      row.each_with_index do | piece, c_idx |
        return [r_idx, c_idx ] if piece.class == King && piece.color == color
      end
    end
  end

  def render_board
    @rows.each do | row |
      puts row
    end
  end

  def in_bounds?(pos)
    pos.first.between?(0,7) && pos.last.between?(0,7)
  end

end
#
# b = Board.new
# p b.find_king(:white)
# rook = b[0, 0]
# b.move_piece([0,0], [3,3])
# p b.rows
# p rook.pos
# p rook.get_slide_moves(:right, rook.pos)
# p rook.get_slide_moves(:left, rook.pos)
# p rook.get_slide_moves(:up, rook.pos)
# p rook.get_slide_moves(:down, rook.pos)


# Setup checkmate Board
# b.move_piece([6, 5], [5, 5])
# b.move_piece([1,4], [3,4])
# b.move_piece([6,6], [4,6])
# b.move_piece([0,3], [4,7])
# p b.render_board
# d = Display.new(b)
# d.display_board
# p b.check?(:white)
# p b.checkmate?(:white)
# puts "POST CHECKMATE"
# # p b.render_board
