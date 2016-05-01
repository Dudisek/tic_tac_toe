require_relative 'spec_helper.rb'


describe Game do
  describe '#determine_game_mode' do
    it "asks for the game mode" do
      expect(Ui).to receive(:red).with(/Choose your game/)
      expect(Ui).to receive(:get_user_input).and_return(1)

      subject.determine_game_mode
    end

    it "memorizes the game mode" do
      expect(Ui).to receive(:get_user_input).and_return(Game::Mode::HUMAN_VS_COMPUTER)

      subject.determine_game_mode

      expect(subject.mode).to eq(Game::Mode::HUMAN_VS_COMPUTER)
    end
  end

  describe '#determine_starter' do
    it "ask in HUMAN_VS_COMPUTER mode and assigns human" do
      expect(Ui).to receive(:get_user_input).and_return(1)
      subject.mode = Game::Mode::HUMAN_VS_COMPUTER
      subject.determine_starter


      expect(subject.player1).to be_a(HumanPlayer)
      expect(subject.player2).to be_a(ComputerPlayer)
    end

    it "ask in HUMAN_VS_COMPUTER mode and assigns computer" do
      expect(Ui).to receive(:get_user_input).and_return(2)
      subject.mode = Game::Mode::HUMAN_VS_COMPUTER
      subject.determine_starter

      expect(subject.player1).to be_a(ComputerPlayer)
      expect(subject.player2).to be_a(HumanPlayer)
    end

    it "doesn't ask in HUMAN_VS_HUMAN mode" do
      expect(Ui).to_not receive(:get_user_input)
      subject.mode = Game::Mode::HUMAN_VS_HUMAN
      subject.determine_starter

      expect(subject.player1).to be_a(HumanPlayer)
      expect(subject.player2).to be_a(HumanPlayer)
    end

    it "doesn't ask in COMPUTER_VS_COMPUTER mode" do
      expect(Ui).to_not receive(:get_user_input)
      subject.mode = Game::Mode::COMPUTER_VS_COMPUTER
      subject.determine_starter

      expect(subject.player1).to be_a(ComputerPlayer)
      expect(subject.player2).to be_a(ComputerPlayer)
    end
  end
end

