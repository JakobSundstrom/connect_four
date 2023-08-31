# frozen_string_literal: true

# ConnectFour represents a game of Connect Four.
#
# It includes methods for initializing the game, dropping pieces into the
# board, checking for wins, draws, and game over conditions, displaying the
# current board, and resetting the game.
#
# Example usage:
#
#   game = ConnectFour.new
#   game.display_board
#
#   until game.game_over?
#     puts "Player #{game.current_player}'s turn"
#     column = gets.chomp.to_i
#     if game.valid_move?(column)
#       game.drop_piece(column)
#       game.display_board
#     else
#       puts "Invalid move! Try again."
#     end
#   end
#
#   if game.win?('X')
#     puts "Player X wins!"
#   elsif game.win?('O')
#     puts "Player O wins!"
#   else
#     puts "It's a draw!"
#   end
class ConnectFour
  attr_reader :board, :current_player

  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
    @current_player = 'X'
  end

  def drop_piece(column, player)
    return unless valid_move?(column)

    row = 5
    row -= 1 while row >= 0 && @board[row][column] != ' '
    @board[row][column] = player
    switch_player
  end

  def valid_move?(column)
    return false if column.negative? || column > 6

    @board[0][column] == ' '
  end

  private

  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end

  def win?(player)
    # Checks if the specified player has won the game
  end

  def draw?
    # Checks if the game is a draw (no more valid moves)
  end

  def game_over?
    # Checks if the game is over (either a win or a draw)
  end

  def display_board
    # Displays the current game board
  end

  def reset
    # Resets the game board for a new game
  end
end
