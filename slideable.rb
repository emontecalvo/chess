module Slideable

  DIRECTIONS = {
    :up => [-1, 0], :down => [1, 0],
    :left => [0, -1], :right => [0, 1],
    :up_right => [-1, 1], :up_left => [-1, -1],
    :down_right => [1, 1], :down_left => [1, -1]
  }

  def get_slide_moves(direction, pos)
    new_row = pos.first + DIRECTIONS[direction].first
    new_column = pos.last + DIRECTIONS[direction].last
    new_position = [new_row, new_column]
    return [] unless @board.in_bounds?(new_position)
    return [] if @board[*new_position].color == self.color # checks for own color
    return [new_position] unless @board[*new_position].color == :null # returns if it finds a non-null
    [new_position].concat(get_slide_moves(direction, new_position))
  end
end
