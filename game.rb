require_relative "board"
require_relative "display"
require_relative "player"
require_relative "chess_errors"

class Game

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @current_player = @player_one
    @board = Board.new
    @display = Display.new(@board)
    set_colors
  end

  def switch_players
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end

  def run
    until won
      play_turn
      if won
        puts "Checkmate! #{@current_player.name} has won!"
        exit
      end
      switch_players
    end
  end

  def play_turn
    @display.display_board
    # get selected piece from user.
    start_pos, end_pos = @current_player.get_move(@display)
    board_sub = @board
    piece_to_be_moved = @board[*start_pos]
    piece_at_target = @board[*end_pos]
    @board.move_piece(start_pos, end_pos)
    if @board.check?(@current_player.color)
      raise SelfInCheckError
    end
  rescue SelfInCheckError => e
    puts "#{e.msg}"
    sleep 1
    @board[*start_pos] = piece_to_be_moved
    piece_to_be_moved.move(start_pos)
    @board[*end_pos] = piece_at_target
    retry
  end

  def set_colors
    @player_one.set_color(:white)
    @player_two.set_color(:black)
  end

  private

  def won
    opponent_color = @current_player.color == :black ? :white : :black
    if @board.check?(opponent_color)
      return true if @board.checkmate?(opponent_color)
    end
    false
  end

end

matt = Player.new("Matt")
emily = Player.new("Emily")

game = Game.new(matt, emily)
# game.play_turn
game.run
