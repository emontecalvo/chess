module Stepable

  def get_potential_moves(move_options)
    potential_moves = []
    move_options.each do | option |
      x_chg, y_chg = option
      new_pos = [@pos.first + x_chg, @pos.last + y_chg]
      potential_moves << new_pos if valid_move?(new_pos)
    end
    potential_moves
  end

end
