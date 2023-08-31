class ConnectFour
  attr_reader :board, :current_player

  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
    @current_player = 'X'
  end

  def drop_piece(column, player)
    # Places a player's piece in the specified column
  end

  def valid_move?(column)
    # Checks if a move in the specified column is valid (i.e., the column is not full)
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
