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

  describe "#valid_move?" do
    context "when the column is empty" do
      it "returns true" do
        game = ConnectFour.new
        expect(game.valid_move?(0)).to be true
      end
    end
  
    context "when the column is partially filled" do
      it "returns true for a valid move" do
        game = ConnectFour.new
        # Fill the column partially
        game.drop_piece(0, 'X')
        game.drop_piece(0, 'O')
        expect(game.valid_move?(0)).to be true
      end
  
      it "returns false for an invalid move" do
        game = ConnectFour.new
        # Fill the column completely
        game.drop_piece(0, 'X')
        game.drop_piece(0, 'O')
        game.drop_piece(0, 'X')
        game.drop_piece(0, 'O')
        game.drop_piece(0, 'X')
        game.drop_piece(0, 'O')
        expect(game.valid_move?(0)).to be false
      end
    end
  
    context "when the column is full" do
      it "returns false" do
        game = ConnectFour.new
        # Fill the column completely
        6.times { game.drop_piece(0, 'X') }
        expect(game.valid_move?(0)).to be false
      end
    end
  
    context "when the column index is out of bounds" do
      it "returns false for negative column index" do
        game = ConnectFour.new
        expect(game.valid_move?(-1)).to be false
      end
  
      it "returns false for column index greater than or equal to board width" do
        game = ConnectFour.new
        expect(game.valid_move?(7)).to be false
        expect(game.valid_move?(100)).to be false
      end
    end
  end

  describe '#win?' do
    context 'when a player has won horizontally' do
      before(:each) do
        @game = ConnectFour.new
      end
      it 'returns true if a player has four consecutive pieces in a row' do
        player = @game.instance_variable_get(:@current_player)
        4.times do |column|
          @game.drop_piece(column, player)
        end

        expect(@game.win?(player)).to be true
      end
      it 'returns false if a player has less than four consecutive pieces in a row' do
        player = @game.instance_variable_get(:@current_player)
        3.times do |column|
          @game.drop_piece(column, player)
        end
        expect(@game.win?(player)).to be false
      end
    end
    context 'when a player has won vertically' do
      before(:each) do
        @game = ConnectFour.new
      end
      it 'returns true if a player has four consecutive pieces in a column' do
        player = @game.instance_variable_get(:@current_player)
        4.times do
          @game.drop_piece(3, player)
        end
        expect(@game.win?(player)).to be true
      end
      it 'returns false if a player has less than four consecutive pieces in a column' do
        player = @game.instance_variable_get(:@current_player)
        3.times do
          @game.drop_piece(3, player)
        end
        expect(@game.win?(player)).to be false
      end
    end
    context 'when a player has won diagonally' do
      before(:each) do
        @game = ConnectFour.new
      end
      it 'returns true if a player has four consecutive pieces diagonally' do
        player = @game.instance_variable_get(:@current_player)
        # Simulate a diagonal win
        @game.drop_piece(0, player)
        @game.drop_piece(1, player)
        @game.drop_piece(1, player)
        @game.drop_piece(2, player)
        @game.drop_piece(2, player)
        @game.drop_piece(2, player)
        @game.drop_piece(3, player)
        @game.drop_piece(3, player)
        @game.drop_piece(3, player)
        @game.drop_piece(3, player)
        expect(@game.win?(player)).to be true
      end
      it 'returns false if a player has less than four consecutive pieces diagonally' do
        player = @game.instance_variable_get(:@current_player)
        # Simulate a diagonal with less than four pieces
        @game.drop_piece(0, player)
        @game.drop_piece(1, player)
        @game.drop_piece(1, player)
        @game.drop_piece(2, player)
        expect(@game.win?(player)).to be false
      end
    end
  end

  describe '#draw?' do
    context 'when the game is not a draw' do
      before(:each) do
        @game = ConnectFour.new
      end

      it 'returns false when there are valid moves left' do
        expect(@game.draw?).to be false
      end

      it 'returns false when there are some valid moves left' do
        # Fill all but one column
        6.times do |row|
          @game.instance_variable_get(:@board)[row][0..5] = ['X', 'O', 'X', 'O', 'X', 'O']
        end

        expect(@game.draw?).to be false
      end
    end

    context 'when the game is a draw' do
      before(:each) do
        @game = ConnectFour.new
        # Fill the entire board
        6.times do |row|
          @game.instance_variable_get(:@board)[row] = ['X', 'O', 'X', 'O', 'X', 'O', 'X']
        end
      end

      it 'returns true when there are no valid moves left' do
        expect(@game.draw?).to be true
      end
    end
  end

  describe '#game_over?' do
    context 'when the game is not over' do
      before(:each) do
        @game = ConnectFour.new
      end
      it 'returns false when there is no win and no draw' do
        expect(@game.game_over?('X')).to be false
      end
    end
    context 'when the game is over' do
      before(:each) do
        @game = ConnectFour.new
      end
      it 'returns true when there is a win' do
        # Simulate a win for 'X'
        @game.instance_variable_get(:@board)[0][0..3] = ['X', 'X', 'X', 'X']
        expect(@game.game_over?('X')).to be true
      end
      it 'returns true when there is a draw' do
        # Fill the entire board
        6.times do |row|
          @game.instance_variable_get(:@board)[row] = ['X', 'O', 'X', 'O', 'X', 'O', 'X']
        end
        expect(@game.game_over?('X')).to be true
      end
    end
  end

  describe '#display_board' do
    it 'displays the current game board'
  end

  describe '#reset' do
    it 'resets the game board for a new game'
  end
end
