WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

class Board
  attr_accessor :cells

  def initialize(cells = nil)
    @cells = cells || Array(1..9)
  end

  def print
    puts @cells.each_slice(3) { |row| puts row.join(" | ")}
  end

  def full?
    @cells.all? { |cell| cell.is_a?(Player) }
  end

  def empty?
    @cells.none? { |cell| cell.is_a?(Player) }
  end

  def cell_free?(cell)
    @cells[cell].is_a?(Integer)
  end

  def free_cells
    (0..8).select { |cell| cell_free?(cell) }
  end

  def update_board(selection, player)
    if @cells[selection].is_a? Integer
      @cells[selection] = player
    else
      false
    end
  end

  def get_new_state(selection, player)
    new_board = Board.new(@cells.clone)
    new_board.update_board(selection, player)
    new_board
  end

  def player_won?(player)
    WIN_COMBINATIONS.any? do |line|
      line.all? { |a| @cells[a] == player }
    end
  end
end
