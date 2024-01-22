require 'gosu'
require './board'

class QueensWindow < Gosu::Window
  ORANGE = 0xffca663a
  GREY = 0xffb2b2b2
  WHITE = 0xffffffff
  RED = 0xffff0000

  module ZIndex
    BACKGROUND, SQUARE, PIECE = (1..100).to_a
  end

  def initialize(board_size, num_queens, square_size, line_width)
    @square_size = square_size
    @square_offset = @square_size + line_width
    @board_size_pixels = @square_size * board_size + line_width * (board_size - 1)
    @board_size = board_size

    super(@board_size_pixels, @board_size_pixels, false)
    self.caption = 'Queens Problem'

    @queen = Gosu::Image.new('queen.png')
    @board = Board.new(board_size, num_queens)
  end

  def draw
    self.draw_quad(
        0, 0, WHITE,
        @board_size_pixels, 0, WHITE,
        0, @board_size_pixels, WHITE,
        @board_size_pixels, @board_size_pixels, WHITE,
        ZIndex::BACKGROUND)

    (0..@board_size-1).each do |row|
      (0..@board_size-1).each do |col|
        square_color = @board.square_attacked?(row, col) && RED ||
            ((row + col) % 2 == 0) && GREY ||
            ORANGE

        self.draw_quad(
            @square_offset * row, @square_offset * col, square_color,
            @square_offset * row + @square_size, @square_offset * col, square_color,
            @square_offset * row, @square_offset * col + @square_size, square_color,
            @square_offset * row + @square_size, @square_offset * col + @square_size, square_color,
            ZIndex::SQUARE)
      end
    end

    @board.queens.each do |queen_x, queen_y|
      @queen.draw(queen_x * @square_offset + 4, queen_y * @square_offset + 3, ZIndex::PIECE)
    end
  end

  def button_down(id)
    case id
      when Gosu::MS_LEFT
        x = (self.mouse_x / @square_offset).to_i
        y = (self.mouse_y / @square_offset).to_i

        (!@board.square_attacked?(x, y) || @board.queen_here?(x, y)) && @board.add_queen(x, y)
        #@board.add_queen((self.mouse_x / @square_offset).to_i, (self.mouse_y / @square_offset).to_i)
      else
    end
  end

  def needs_cursor?
    true
  end
end
