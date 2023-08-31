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

      it 'initializes the current player (usually "X" or "O")' do
        expect(@game.instance_variable_get(:@current_player)).to satisfy { |player| player == 'X' || player == 'O' }
      end
    end
  end

  describe '#drop_piece' do
    context 'when a valid move is made' do
      before(:each) do
        @game = ConnectFour.new
      end
  
      it 'drops a player\'s piece into the specified column' do
        column = 3
        player = @game.instance_variable_get(:@current_player)
        @game.drop_piece(column, player)
  
        expect(@game.board[5][column]).to eq(player)
      end
  
      it 'updates the game board with the new piece' do
        column = 2
        player = @game.instance_variable_get(:@current_player)
        @game.drop_piece(column, player)
  
        expect(@game.board).to eq([
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', player, ' ', ' ', ' ', ' ']
        ])
      end
  
      it 'switches to the next player\'s turn' do
        current_player = @game.instance_variable_get(:@current_player)
        @game.drop_piece(4, current_player)
        next_player = @game.instance_variable_get(:@current_player)
  
        expect(next_player).not_to eq(current_player)
      end
    end
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
