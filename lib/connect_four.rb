# frozen_string_literal: true

# ConnectFour represents a game of Connect Four.
#
# It includes methods for initializing the game, dropping pieces into the
# board, checking for wins, draws, and game over conditions, displaying the
# current board, and resetting the game.

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
    return true if win?(player)
    # Check for a draw (no valid moves left)
    return true if draw?

    false # The game is not over
  end

  def display_board
    puts "  0 1 2 3 4 5 6"
    @board.each_with_index do |row, index|
      display_row = row.map { |cell| cell == ' ' ? '_' : cell }
      puts "#{index} #{display_row.join(' ')}"
    end
  end

  def reset
    @board = Array.new(6) { Array.new(7, ' ') }
    @current_player = 'X'
  end

  def play
    display_board
    until game_over?(@current_player)
      puts "Player #{@current_player}'s turn. Enter column (0-6) to drop your piece:"
      column = gets.chomp.to_i

      if valid_move?(column)
        drop_piece(column, @current_player)
        display_board
        if win?('X')
          puts 'Player X wins!'
          break
        elsif win?('O')
          puts 'Player O wins!'
          break
        elsif draw?
          puts "It's a draw!"
          break
        end
      else
        puts 'Invalid move! Please choose a valid column.'
      end
    end
  end
end

# game = ConnectFour.new
# game.play

