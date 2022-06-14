require './lib/board.rb'

describe Board do
  subject(:board) { described_class.new}
  
  describe "#initialize" do
    # No test necessary
  end

  describe "#show_board" do
    before do
      allow(board).to receive(:puts)
    end

    it 'prints the board' do
      expect(board).to receive(:puts)
      board.show_board
    end
  end

  describe "#update_positions" do
    context 'when position has not been played' do
      before do
        allow(board).to receive(:update_board)
        allow(board).to receive(:valid_position?).and_return(true)
      end

      it 'does not display error message' do
        position_to_play = 1
        expect(board).not_to receive(:puts).with("Cannot play here")
        board.update_positions(position_to_play, "X")
      end

      it 'sends message to update the board' do
        position_to_play = 1
        expect(board).to receive(:update_board)
        board.update_positions(position_to_play, "X") 
      end
    end

    context 'when position has been played' do
      before do
        allow(board).to receive(:update_board)
        allow(board).to receive(:valid_position?).and_return(false)
      end

      it 'displays error message' do
        position_to_play = 1
        expect(board).to receive(:puts).with("Cannot play here")
        board.update_positions(position_to_play, "X") 
      end

      it 'does not send message to update the board' do
        position_to_play = 1
        expect(board).not_to receive(:update_board)
        board.update_positions(position_to_play, "X")  
      end 
    end
  end

  describe "#update_board" do
    context 'when position has been played' do
      it 'updates board with symbol' do
        board.update_positions(1, "X")
        board.update_board
        expect(board.board).to include('X')
      end
    end
  end

  describe "#valid_position?" do
    let(:positions) {board.instance_variable_get(:@positions)}
    it 'returns true if the position and value at position are the same' do
      positions[0] = 1
      result = board.valid_position?(1)
      expect(result).to be true
    end

    it 'returns false if the position and value at position are not the same' do
      positions[0] = 2
      result = board.valid_position?(1)
      expect(result).to be false
    end
  end

  describe "#game_over?" do
    context 'when board is new' do
      subject(:new_board) {described_class.new()}
      it 'does not have any symbols' do
        expect(new_board.board).not_to match(/[xo]/i)
      end
    end

    context 'when board does not have complete row' do
      subject(:incomplete_row_board) { described_class.new()}
      it 'is not game over' do
        incomplete_row_board.instance_variable_set(:@positions, ['X', 'X', 3, 4, 5, 6, 7, 8, 9])
        expect(incomplete_row_board.game_over?('X')).to be false
      end
    end

    context 'when board does not have complete column' do
      subject(:incomplete_col_board) { described_class.new()}
      it 'is not game over' do
        incomplete_col_board.instance_variable_set(:@positions, ['X', 2, 3, 'X', 5, 6, 7, 8, 9])
        expect(incomplete_col_board.game_over?('X')).to be false 
      end
    end

    context 'when board does not have complete diagonal' do
      subject(:incomplete_dia_board) { described_class.new()}
      it 'is not game over' do
        incomplete_dia_board.instance_variable_set(:@positions, ['X', 2, 3, 4, 'X', 6, 7, 8, 9])
        expect(incomplete_dia_board.game_over?('X')).to be false  
      end
    end

    context 'when board has a complete row' do
      subject(:complete_row_board) {described_class.new}
      it 'is game over' do
        complete_row_board.instance_variable_set(:@positions, ['X', 'X', 'X', 4, 5, 6, 7, 8, 9])
        expect(complete_row_board.game_over?('X')).to be true
      end
    end

    context 'when board has a complete col' do
      subject(:complete_col_board) {described_class.new}
      it 'is game over' do
        complete_col_board.instance_variable_set(:@positions, ['X', 2, 3, 'X', 5, 6, 'X', 8, 9])
        expect(complete_col_board.game_over?('X')).to be true
      end
    end

    context 'when board has a complete diagonal' do
      subject(:complete_dia_board) {described_class.new}
      it 'is game over' do
        complete_dia_board.instance_variable_set(:@positions, ['X', 2, 3, 4, 'X', 6, 7, 8, 'X'])
        expect(complete_dia_board.game_over?('X')).to be true
      end
    end
  end

  describe "#board_full?" do
    context 'when no position has been played' do
      subject(:new_board) { described_class.new}
      it 'returns false' do
        expect(new_board.board_full?).to be false
      end
    end

    context 'when some positions have been played' do
      subject(:played_board) {described_class.new}
      it 'returns false' do
        played_board.instance_variable_set(:@positions, ['X', 2, 3, 4, 5, 6, 7, 8, 9])
        expect(played_board.board_full?).to be false
      end
    end

    context 'when all positions have been played' do
      subject(:full_board) {described_class.new}
      it 'returns true' do
        full_board.instance_variable_set(:@positions, ['X', 'O', 'X', 'O', 'X', 'O', 'O', 'X', 'O'])
        expect(full_board.board_full?).to be true
      end
    end
  end
end
