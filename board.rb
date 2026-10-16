require_relative 'player'

class Board
    attr_accessor :history, :code
    
    def initialize(code)
        @history = {}
        @code = code
    end

    def show_history
        history.each do |k,v|
            puts "#{k}=> #{v}"
        end
    end

    def record_history(guess, hint)
    end

    def compare_guess(guess)
        show_history()
        
        if @code == guess
            puts "Bravo! you cracked the code! it was indeed #{code}"
            return true
        end

    end

end
    