require './lib/connect_four.rb'

describe ConnectFour do
  describe '#initialize' do
    context 'when a new game is started' do
      before(:each) do
        @game = ConnectFour.new
      end

      it 'initializes an empty game board (6 rows x 7 columns)' do
        expect(@game.instance_variable_get(:@board)).to eq([
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ']
        ])
      end

      xit 'initializes the current player (usually "X" or "O")' do
        expect(@game.instance_variable_get(:@current_player)).to satisfy { |player| player == 'X' || player == 'O' }
      end
    end
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
