class Player
  attr_reader :char

  def initialize(order)
    @order = order
    if @order == :one
      @char = "X".colorize(:light_blue)
    else
      @char = "O".colorize(:red)
    end
  end

  def play(board, _other)
    raise "Not implemented"
  end

  def name
    raise "Not implemented"
  end

  def to_s
    @char
  end
end

class HumanPlayer < Player
  def play(board, _other)
    Ui.puts "#{name}: Please select an empty cell (1-9):"
    loop do
      selection = Ui.get_user_input
      unless (1..9).include?(selection) && board.cell_free?(selection - 1)
        Ui.puts "Invalid input. Please select an empty cell (1-9):"
        next
      end

      board.update_board(selection - 1, self)
      break
    end
  end

  def name
    "Player #{@order == :one ? "one" : "two"}"
  end
end

class ComputerPlayer < Player
  def play(board, other)
    @other = other

    Ui.red "Computer AL: thinking..."
    sleep 1
    if board.empty?
      # Just pick a corner in the first move
      board.update_board([0,2,6,8].sample, self)
    else
      minimax(board, self)
      board.update_board(@choice, self)
    end
  end

  def minimax(board, player)
    if board.player_won?(self)
      return 10
    elsif board.player_won?(@other)
      return -10
    elsif board.full?
      return 0
    end

    scores = []
    moves = []

    board.free_cells.each do |move|
      possible_board = board.get_new_state(move, player)
      scores.push minimax(possible_board, player == self ? @other : self)
      moves.push move
    end

    if player == self
        max_score_index = scores.each_with_index.max[1]
        @choice = moves[max_score_index]
        return scores[max_score_index]
    else
        min_score_index = scores.each_with_index.min[1]
        @choice = moves[min_score_index]
        return scores[min_score_index]
    end
end

  def name
    "Computer #{@order == :one ? "one" : "two"}"
  end
end
