require '../board'

describe Board do
  describe "a new board" do
    it "should have no queens and no attacked squares" do
      board = Board.new 8, 8
      board.queens.length.should == 0

      (0..7).each do |row|
        (0..7).each do |col|
          board.square_attacked?(row, col).should be false
        end
      end
    end
  end

  describe "adding queens" do
    it "should add a queen at the correct place" do
      board = Board.new 3, 1
      board.queens.length.should == 0

      board.add_queen(1, 0)
      board.queens.length.should == 1
      board.queens[0].should == [1, 0]
      board.queen_here?(1, 0).should be true
    end

    it "should not let you add more queens than specified" do
      board = Board.new 3, 0
      board.queens.length.should == 0

      board.add_queen(0, 0)
      board.queens.length.should == 0
    end

    it "should update the attacked squares" do
      board = Board.new 3, 1

      (0..2).each do |row|
        (0..2).each do |col|
          board.square_attacked?(row, col).should be false
        end
      end

      board.add_queen(1, 1)

      (0..2).each do |row|
        (0..2).each do |col|
          board.square_attacked?(row, col).should be true
        end
      end
    end
  end

  describe "#all_squares_attacked?" do
    it "should report true or false correctly" do
      board = Board.new 3, 1
      board.all_squares_attacked?.should be false

      board.add_queen(1, 1)
      board.all_squares_attacked?.should be true
    end
  end
end
