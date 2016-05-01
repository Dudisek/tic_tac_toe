require_relative "../lib/tictactoe.rb"

RSpec.configure do |config|
  config.before(:each) do
    allow(Ui).to receive(:puts)
  end
end
