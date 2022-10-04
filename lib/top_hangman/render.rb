module TopHangman
  class Render
    def ask_for_guess
      puts 'Guess a letter:'
      gets.chomp
    end
  end
end
