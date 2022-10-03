require 'byebug'
require './lib/main'

RSpec.configure do |config|
  # Use the specified formatter
  config.formatter = :documentation
end
