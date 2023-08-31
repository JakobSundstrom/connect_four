require 'rspec'

describe ConnectFour do
  describe '#initialize' do
    it 'initializes the game board and sets up the initial game state'
  end

  describe '#drop_piece' do
    it 'places a player\'s piece in the specified column'
  end

  describe '#valid_move?' do
    it 'checks if a move in the specified column is valid (column not full)'
  end

  describe '#win?' do
    it 'checks if the specified player has won the game'
  end

  describe '#draw?' do
    it 'checks if the game is a draw (no more valid moves)'
  end

  describe '#game_over?' do
    it 'checks if the game is over (either a win or a draw)'
  end

  describe '#display_board' do
    it 'displays the current game board'
  end

  describe '#reset' do
    it 'resets the game board for a new game'
  end
end
 