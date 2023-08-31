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

  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end

  def win?(player)
    return true if horizontal_win?(player) || vertical_win?(player) || diagonal_win?(player)

    false # No win condition found
  end

  def horizontal_win?(player)
    6.times do |row|
      4.times do |col|
        return true if (0..3).all? { |i| @board[row][col + i] == player }
      end
    end
    false
  end

  def vertical_win?(player)
    7.times do |col|
      3.times do |row|
        return true if (0..3).all? { |i| @board[row + i][col] == player }
      end
    end
    false
  end

  def diagonal_win?(player)
    return true if diagonal_win_left_to_right?(player) || diagonal_win_right_to_left?(player)

    false
  end

  def diagonal_win_left_to_right?(player)
    3.times do |row|
      4.times do |col|
        return true if (0..3).all? { |i| @board[row + i][col + i] == player }
      end
    end
    false
  end

  def diagonal_win_right_to_left?(player)
    3.times do |row|
      3.upto(6) do |col|
        return true if (0..3).all? { |i| @board[row + i][col - i] == player }
      end
    end
    false
  end

  def draw?
    # Check if the top row of the board has any empty spaces
    @board[0].none? { |piece| piece == ' ' }
  end

  def game_over?(player)
    # Check for a win first
    if win?(player)
      return true
    end
  
    # If there's no win, check for a draw
    if draw?
      return true
    end
  
    # If neither win nor draw condition is met, and it's not the current player's turn, the game is over
    if @current_player != player
      return true
    end
  
    false # The game is not over
  end
  
  

  def display_board
    # Displays the current game board
  end

  def reset
    # Resets the game board for a new game
  end
end
