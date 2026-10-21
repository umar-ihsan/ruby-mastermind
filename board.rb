require_relative 'player'

class Board
    attr_accessor :history, :code
    
    def initialize(code)
        @history = {}
        @code = code
    end

    def give_hint(guess)

        hints = []
     
        guess.each_with_index do |g, index_g|
            @code.each_with_index do |c, index_c|
                if g == c
                    if index_g == index_c
                        hints << "Complete"
                    else
                        hints << "Partial"
                    end
                else
                    hints << "Wrong"
                end
            end
        end
        hints
    end

    def show_history(guess)
        hint = give_hint(guess)
        @history[guess] = hint
        puts "=============HINTS BOARD=================="
        @history.each do |k,v|
            puts "#{k}=> #{v}"
        end
        puts "=========================================="
    end

    def record_history(guess, hint)
    end

    def compare_guess(guess)
        show_history(guess)
        
        if @code == guess
            puts "Bravo! you cracked the code! it was indeed #{code}"
            return true
        end

    end

end
    