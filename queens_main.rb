#!/usr/local/bin/ruby -w

require './queens_window'

# For the "queens attacking all squares" problem:
# (from http://mathworld.wolfram.com/QueensProblem.html)
# 1x1 thru 3x3 requires 1 queen (trivial)
# 4x4 requires 2 queens
# 5x5 requires 3 queens
# 6x6 requires 3 queens
# 7x7 requires 4 queens
# 8x8 requires 5 queens
# beyond that?...

BOARD_SIZE = 8
NUM_QUEENS = 8
SQUARE_SIZE = 57
LINE_WIDTH = 2

window = QueensWindow.new BOARD_SIZE, NUM_QUEENS, SQUARE_SIZE, LINE_WIDTH
window.show