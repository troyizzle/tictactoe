require_relative "../tic_tac_toe"

describe TicTacToe do
  describe "invalid board" do
    context "with empty board" do
      subject { TicTacToe.new([]).winner }

      it { expect { subject }.to raise_error("No game board") }
    end

    context "with mismatched row lengths" do
      subject do
        TicTacToe.new([["x", "o"], ["x", "x", "x"], ["x", "x", "x"]]).winner
      end

      it { expect { subject }.to raise_error("Invalid rows") }
    end

    context "with invalid input" do
      subject do
        TicTacToe.new([["b", "x", "c"], ["x", " ", "o"], ["x", "x", "x"]])
          .winner
      end

      it { expect { subject }.to raise_error("Invalid input") }
    end

    context "with invalid rows length" do
      subject { TicTacToe.new([["x", " ", "o"], ["x", "x", "x"]]).winner }

      it { expect { subject }.to raise_error("Invalid row length") }
    end

    [1, 'foo', { foo: 'bar' }, false, :test, nil].each do |type|
      context "with #{type} board" do
        subject { TicTacToe.new(type).winner }

        it { expect { subject }.to raise_error("Invalid board") }
      end
    end
  end

  describe "rows" do
    it "returns the correct winner when match found on the first row" do
      board_o = [
        ["o", "o", "o"],
        ["x", "x", " "],
        [" ", " ", " "]
      ]

      board_x = [
        ["x", "x", "x"],
        ["o", "o", " "],
        ["o", " ", " "]
      ]

      expect(TicTacToe.new(board_o).winner).to eq("o")
      expect(TicTacToe.new(board_x).winner).to eq("x")
    end

    it "returns the correct winner when match found on the second row" do
      board_o = [
        ["x", "x", " "],
        ["o", "o", "o"],
        [" ", " ", " "]
      ]

      board_x = [
        ["o", "o", " "],
        ["x", "x", "x"],
        ["o", " ", " "]
      ]

      expect(TicTacToe.new(board_o).winner).to eq("o")
      expect(TicTacToe.new(board_x).winner).to eq("x")
    end

    it "returns the correct winner when match found on the third row" do
      board_o = [
        ["x", "x", " "],
        [" ", " ", " "],
        ["o", "o", "o"]
      ]

      board_x = [
        ["o", "o", " "],
        ["o", " ", " "],
        ["x", "x", "x"]
      ]

      expect(TicTacToe.new(board_o).winner).to eq("o")
      expect(TicTacToe.new(board_x).winner).to eq("x")
    end
  end

  describe "columns" do
    it "returns the correct winner when match found on the first column" do
      board_o = [
        ["o", "x", " "],
        ["o", "x", " "],
        ["o", " ", " "]
      ]

      board_x = [
        ["x", "o", " "],
        ["x", "o", " "],
        ["x", " ", "o"]
      ]

      expect(TicTacToe.new(board_o).winner).to eq("o")
      expect(TicTacToe.new(board_x).winner).to eq("x")
    end

    it "returns the correct winner when match found on the second column" do
      board_o = [
        ["x", "o", " "],
        ["x", "o", " "],
        [" ", "o", " "]
      ]

      board_x = [
        ["o", "x", " "],
        ["o", "x", " "],
        [" ", "x", "o"]
      ]

      expect(TicTacToe.new(board_o).winner).to eq("o")
      expect(TicTacToe.new(board_x).winner).to eq("x")
    end

    it "returns the correct winner when match found on the third column" do
      board_o = [
        ["x", " ", "o"],
        ["x", " ", "o"],
        [" ", " ", "o"]
      ]

      board_x = [
        ["o", " ", "x"],
        ["o", " ", "x"],
        [" ", "o", "x"]
      ]

      expect(TicTacToe.new(board_o).winner).to eq("o")
      expect(TicTacToe.new(board_x).winner).to eq("x")
    end
  end

  describe "diagonals" do
    it "returns the correct winner when match found in backward diagonal" do
      board_o = [
        ["o", "x", " "],
        ["x", "o", " "],
        [" ", " ", "o"]
      ]

      board_x = [
        ["x", "o", " "],
        ["o", "x", " "],
        ["o", " ", "x"]
      ]

      expect(TicTacToe.new(board_o).winner).to eq("o")
      expect(TicTacToe.new(board_x).winner).to eq("x")
    end

    it "returns the correct winner when match found in forward diagonal" do
      board_o = [
        [" ", "x", "o"],
        ["x", "o", " "],
        ["o", " ", " "]
      ]

      board_x = [
        ["o", "o", "x"],
        ["o", "x", " "],
        ["x", " ", " "]
      ]

      expect(TicTacToe.new(board_o).winner).to eq("o")
      expect(TicTacToe.new(board_x).winner).to eq("x")
    end
  end

  describe "draws" do
    it "returns 'draw' when the board is a draw" do
      board = [
        ["o", "x", "o"],
        ["o", "x", "x"],
        ["x", "o", "o"]
      ]

      expect(TicTacToe.new(board).winner).to eq("draw")
    end
  end

  describe "unfinished" do
    it "returns 'unfinished' when the board is not finished'" do
      board = [
        ["o", " ", "o"],
        ["x", " ", "x"],
        ["o", "x", "o"]
      ]

      expect(TicTacToe.new(board).winner).to eq("unfinished")
    end
  end

  describe "5 x 5 board" do
    it "returns the correct winner when match found on a row" do
      board = [
        ["o", "o", "o", "o", "o"],
        ["x", "x", " ", " ", " "],
        ["x", "x", "x", " ", " "],
        [" ", " ", " ", " ", " "],
        [" ", " ", " ", " ", " "]
      ]

      expect(TicTacToe.new(board).winner).to eq("o")
    end

    it "returns the correct winner when match found on a column" do
      board = [
        ["o", "x", "x", " ", " "],
        ["o", "x", " ", " ", " "],
        ["o", "x", "x", " ", " "],
        ["o", " ", " ", " ", " "],
        ["o", " ", " ", " ", " "]
      ]

      expect(TicTacToe.new(board).winner).to eq("o")
    end

    it "returns the correct winner when match found on a forward diagonal" do
      board = [
        [" ", "x", "x", " ", "o"],
        [" ", "x", " ", "o", " "],
        ["x", "x", "o", " ", " "],
        [" ", "o", " ", " ", " "],
        ["o", " ", " ", " ", " "]
      ]

      expect(TicTacToe.new(board).winner).to eq("o")
    end

    it "returns the correct winner when match found on a backward diagonal" do
      board = [
        ["o", "x", "x", " ", " "],
        [" ", "o", " ", "x", " "],
        ["x", "x", "o", " ", " "],
        [" ", " ", " ", "o", " "],
        [" ", " ", " ", " ", "o"]
      ]

      expect(TicTacToe.new(board).winner).to eq("o")
    end
  end

  describe "7 x 7 board" do
    it "returns the correct winner when match found on a row" do
      board = [
        ["o", "o", "o", "o", "o", "o", "o"],
        ["o", " ", "x", " ", "x", " ", " "],
        ["x", " ", " ", " ", "o", " ", " "],
        [" ", "x", "o", " ", "x", " ", " "],
        [" ", "x", "o", " ", " ", " ", " "],
        [" ", "o", " ", " ", " ", " ", " "],
        [" ", "x", " ", " ", " ", " ", " "],
      ]

      expect(TicTacToe.new(board).winner).to eq("o")
    end

    it "returns the correct winner when match found on a column" do
      board = [
        ["o", "x", "o", "o", "o", "o", "o"],
        ["o", " ", "x", " ", "x", " ", " "],
        ["o", " ", " ", " ", "o", " ", " "],
        ["o", "x", "o", " ", "x", " ", " "],
        ["o", "x", "o", " ", " ", " ", " "],
        ["o", "o", " ", " ", " ", " ", " "],
        ["o", "x", " ", " ", " ", " ", " "],
      ]

      expect(TicTacToe.new(board).winner).to eq("o")
    end

    it "returns the correct winner when match found on a forward diagonal" do
      board = [
        ["o", "x", "o", "o", "o", "o", "o"],
        ["x", " ", "x", " ", "x", "o", " "],
        ["o", " ", " ", " ", "o", " ", " "],
        ["o", "x", "o", "o", "x", " ", " "],
        ["o", "x", "o", " ", " ", " ", " "],
        ["o", "o", " ", " ", " ", " ", " "],
        ["o", "x", " ", " ", " ", " ", " "],
      ]

      expect(TicTacToe.new(board).winner).to eq("o")
    end

    it "returns the correct winner when match found on a backward diagonal" do
      board = [
        ["o", "x", "o", "o", "o", "o", "o"],
        ["x", " ", "x", " ", "x", "o", " "],
        ["o", " ", " ", " ", "o", " ", " "],
        ["o", "x", "o", "o", "x", " ", " "],
        ["o", "x", "o", " ", " ", " ", " "],
        ["o", "o", " ", " ", " ", " ", " "],
        ["o", "x", " ", " ", " ", " ", " "],
      ]

      expect(TicTacToe.new(board).winner).to eq("o")
    end
  end

  describe "9 x 9 board" do
    it "returns the correct winner when match found on a row" do
      board = [
        ["o", "o", "o", "o", "o", "o", "o", "o", "o"],
        ["o", " ", "x", " ", "x", " ", " ", " ", " "],
        ["x", " ", " ", " ", "o", " ", " ", " ", " "],
        [" ", "x", "o", " ", "x", " ", " ", " ", " "],
        [" ", "x", "o", " ", " ", " ", " ", " ", " "],
        [" ", "o", " ", " ", " ", " ", " ", " ", " "],
        [" ", "x", " ", " ", " ", " ", " ", " ", " "],
        [" ", "x", " ", " ", " ", " ", " ", " ", " "],
        [" ", "x", " ", " ", " ", " ", " ", " ", " "],
      ]

      expect(TicTacToe.new(board).winner).to eq("o")
    end

    it "returns the correct winner when match found on a column" do
      board = [
        ["o", "x", "o", "o", "o", "o", "o", " ", " "],
        ["o", " ", "x", " ", "x", " ", " ", " ", " "],
        ["o", " ", " ", " ", "o", " ", " ", " ", " "],
        ["o", "x", "o", " ", "x", " ", " ", " ", " "],
        ["o", "x", "o", " ", " ", " ", " ", " ", " "],
        ["o", "o", " ", " ", " ", " ", " ", " ", " "],
        ["o", "x", " ", " ", " ", " ", " ", " ", " "],
        ["o", "x", " ", " ", " ", " ", " ", " ", " "],
        ["o", "x", " ", " ", " ", " ", " ", " ", " "],
      ]

      expect(TicTacToe.new(board).winner).to eq("o")
    end

    it "returns the correct winner when match found on a forward diagonal" do
      board = [
        ["o", "x", "o", "o", "o", "o", "o", " ", "o"],
        ["x", " ", "x", " ", "x", "o", " ", "o", " "],
        ["o", " ", " ", " ", "o", " ", "o", " ", " "],
        ["o", "x", "o", "o", "x", "o", " ", " ", " "],
        ["o", "x", "o", " ", "o", " ", " ", " ", " "],
        ["o", "o", " ", "o", " ", " ", " ", " ", " "],
        ["o", "x", "o", " ", " ", " ", " ", " ", " "],
        ["o", "o", "o", " ", " ", " ", " ", " ", " "],
        ["o", "o", "o", " ", " ", " ", " ", " ", " "],
      ]

      expect(TicTacToe.new(board).winner).to eq("o")
    end

    it "returns the correct winner when match found on a backward diagonal" do
      board = [
        ["o", "x", "o", "o", "o", "o", "o", " ", "o"],
        ["x", " ", "x", " ", "x", "o", " ", "o", " "],
        ["o", " ", " ", " ", "o", " ", "o", " ", " "],
        ["o", "x", "o", "o", "x", "o", " ", " ", " "],
        ["o", "x", "o", " ", "o", " ", " ", " ", " "],
        ["o", "o", " ", "o", " ", " ", " ", " ", " "],
        ["o", "x", "o", " ", " ", " ", " ", " ", " "],
        ["o", "o", " ", " ", " ", " ", " ", " ", " "],
        ["o", "x", " ", " ", " ", " ", " ", " ", " "],
      ]

      expect(TicTacToe.new(board).winner).to eq("o")
    end
  end


  describe "unfinished" do
    it "returns 'unfinished' when the board not finished yet" do
      board = [
        ["o", "x", "o"],
        ["o", "x", "x"],
        ["x", "o", " "]
      ]

      expect(TicTacToe.new(board).winner).to eq("unfinished")
    end
  end
end
