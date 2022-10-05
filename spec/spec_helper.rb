require 'byebug'
require './lib/top_hangman/game'
require './lib/top_hangman/round'
require './lib/top_hangman/board'

RSpec.configure do |config|
  # Use the specified formatter
  config.formatter = :documentation
end
