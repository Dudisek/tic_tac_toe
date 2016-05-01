class Game
  class Mode
    INVALID = -1
    HUMAN_VS_HUMAN = 1
    HUMAN_VS_COMPUTER = 2
    COMPUTER_VS_COMPUTER = 3
  end

  attr_accessor :mode, :player1, :player2

  def initialize
    @mode = Mode::INVALID
    @board = Board.new
    @winner = nil
    @current_turn = 1

    Ui.yellow "***************************"
    Ui.yellow "* Welcome to Tic Tac Toe! *"
    Ui.yellow "***************************"
  end

  def determine_game_mode
    Ui.red "Choose your game: "
    Ui.puts " Press 1 for Human vs Human \n Press 2 for Human vs Computer \n Press 3 for Computer vs Computer"
    Ui.green "Enter a number:"

    while @mode == Mode::INVALID
      selection = Ui.get_user_input
      unless (1..3).include?(selection)
        Ui.puts "Invalid input. Please select a number 1 to 3."
        next
      end

      @mode = selection
    end

    print_game_mode
  end

  def print_game_mode
    case @mode
    when Mode::HUMAN_VS_HUMAN
      Ui.puts 'You choose Human vs Human!'
    when Mode::HUMAN_VS_COMPUTER
      Ui.puts 'You choose Human vs Computer'
    when Mode::COMPUTER_VS_COMPUTER
      Ui.puts 'You choose Computer vs Computer'
    end
  end

  def determine_starter
    if @mode == Mode::HUMAN_VS_HUMAN
      @player1 = HumanPlayer.new(:one)
      @player2 = HumanPlayer.new(:two)
    elsif @mode == Mode::HUMAN_VS_COMPUTER
      Ui.red "Who starts the game: "
      Ui.puts " Press 1 for Human \n Press 2 for Computer "

      loop do
        selection = Ui.get_user_input
        unless (1..2).include?(selection)
          Ui.puts "Invalid input. Please select 1 or 2."
          next
        end

        if selection == 1
          @player1 = HumanPlayer.new(:one)
          @player2 = ComputerPlayer.new(:two)
        else
          @player1 = ComputerPlayer.new(:one)
          @player2 = HumanPlayer.new(:two)
        end
        break
      end
    elsif @mode == Mode::COMPUTER_VS_COMPUTER
      @player1 = ComputerPlayer.new(:one)
      @player2 = ComputerPlayer.new(:two)
    end
  end

  def start
    @board.print
    play until game_over?
    result_msg
  end

  def game_over?
    @current_turn > 9 || @winner
  end

  def play
    if @current_turn % 2 != 0
      player = @player1
      other = @player2
    else
      player = @player2
      other = @player1
    end

    player.play(@board, other)
    @board.print
    @winner = player if @board.player_won?(player)

    @current_turn += 1
  end

  def result_msg
    Ui.puts "Game over!"
    if !@winner
      Ui.puts "It's a tie."
    else
      Ui.puts "Congrats, #{@winner.name}. You win!"
    end
  end
end
