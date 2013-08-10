require 'gosu'
require './board'

class QueensWindow < Gosu::Window
	ORANGE = 0xffca663a
	GREY   = 0xffb2b2b2
	WHITE  = 0xffffffff
	RED    = 0xffff0000

	module Z
		Background, Square, Piece = (1..100).to_a
	end

	def initialize(board_size, num_queens, square_size, line_width)
		@SQUARE_SIZE = square_size
		@SQUARE_OFFSET = @SQUARE_SIZE + line_width
		@BOARD_SIZE_PIXELS = @SQUARE_SIZE * board_size + line_width * (board_size - 1)
		@BOARD_SIZE = board_size
	
		super(@BOARD_SIZE_PIXELS, @BOARD_SIZE_PIXELS, false)
		self.caption = 'Queens Problem'
		
		@queen = Gosu::Image.new(self, 'queen.png', true)
		@board = Board.new(board_size, num_queens)	
  	end
  
	def draw
		self.draw_quad(
			0, 0, WHITE,
			@BOARD_SIZE_PIXELS, 0, WHITE,
			0, @BOARD_SIZE_PIXELS, WHITE,
			@BOARD_SIZE_PIXELS, @BOARD_SIZE_PIXELS, WHITE,
			Z::Background)
		
		(0..@BOARD_SIZE-1).each do |row|
			(0..@BOARD_SIZE-1).each do |col|
				square_color = @board.square_attacked?(row, col) && RED  ||
							   ((row + col) % 2 == 0) 			 && GREY ||
							   										ORANGE
				
				self.draw_quad(
					@SQUARE_OFFSET * row, 			     @SQUARE_OFFSET * col,                square_color,
					@SQUARE_OFFSET * row + @SQUARE_SIZE, @SQUARE_OFFSET * col, 			      square_color,
					@SQUARE_OFFSET * row, 			     @SQUARE_OFFSET * col + @SQUARE_SIZE, square_color,
					@SQUARE_OFFSET * row + @SQUARE_SIZE, @SQUARE_OFFSET * col + @SQUARE_SIZE, square_color,
					Z::Square)
			end
		end

		@board.queens.each do |queen_x, queen_y|
			@queen.draw(queen_x * @SQUARE_OFFSET + 4, queen_y * @SQUARE_OFFSET + 3, Z::Piece)
		end
	end
	
	def button_down(id)
		case id
		when Gosu::MsLeft
			@board.add_queen((self.mouse_x / @SQUARE_OFFSET).to_i, (self.mouse_y / @SQUARE_OFFSET).to_i)
		end
	end
	
	def needs_cursor?
  		true
  	end
end