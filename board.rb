# TODO make it easier to switch between the two queens problems (no queens attacking each other vs queens attacking all squares)

class Board
  def initialize(board_size, num_queens)
    @num_queens = num_queens
    @board_size = board_size

    @queens = []
    @attacked_squares = Array.new(@board_size) { Array.new(@board_size, false) }
  end

  def queens
    Array.new(@queens).freeze
  end

  def add_queen(queen_x, queen_y)
    new_queen = [queen_x, queen_y]

    if @queens.include?(new_queen)
      @queens.delete(new_queen)
    elsif @queens.length < @num_queens
      @queens.push(new_queen)
    end

    update_attacked
  end

  def update_attacked
    (0..@board_size-1).each do |row|
      (0..@board_size-1).each do |col|
        @attacked_squares[row][col] = false
      end
    end

    @queens.each do |queen_x, queen_y|
      row_offset = 1

      while queen_y - row_offset >= 0
        if queen_x - row_offset >= 0
          @attacked_squares[queen_x - row_offset][queen_y - row_offset] = true
        end

        if queen_x + row_offset < @board_size
          @attacked_squares[queen_x + row_offset][queen_y - row_offset] = true
        end

        row_offset += 1
      end

      row_offset = 1

      while queen_y + row_offset < @board_size
        if queen_x - row_offset >= 0
          @attacked_squares[queen_x - row_offset][queen_y + row_offset] = true
        end

        if queen_x + row_offset < @board_size
          @attacked_squares[queen_x + row_offset][queen_y + row_offset] = true
        end

        row_offset += 1
      end

      (0..@board_size-1).each do |row_or_col|
        @attacked_squares[queen_x][row_or_col] = true
        @attacked_squares[row_or_col][queen_y] = true
      end
    end
  end

  def all_squares_attacked?
    @attacked_squares.flatten.all?
  end

  def square_attacked?(row, col)
    @attacked_squares[row][col]
  end

  def queen_here?(row, col)
    @queens.include?([row, col])
  end

  private :update_attacked
end