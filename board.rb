class Board
    attr_accessor :history, :code

    def initialize(code)
        @history = []
        @code = code
    end

    # returns [exact, partial] for a guess against a code
    def self.score(guess, code)
        exact = 0
        code_left = []
        guess_left = []

        # pass 1: exact matches (right digit, right place)
        guess.each_with_index do |g, i|
            if g == code[i]
                exact += 1
            else
                code_left << code[i]
                guess_left << g
            end
        end

        # pass 2: right digit, wrong place, using each code digit at most once
        partial = 0
        guess_left.each do |g|
            idx = code_left.index(g)
            if idx
                partial += 1
                code_left.delete_at(idx)
            end
        end

        [exact, partial]
    end

    def give_hint(guess)
        exact, partial = Board.score(guess, @code)
        ["Complete"] * exact + ["Partial"] * partial
    end

    def show_history(guess)
        @history << [guess, give_hint(guess)]
        puts "=============HINTS BOARD=================="
        @history.each do |g, hint|
            puts "#{g.join}=> #{hint}"
        end
        puts "=========================================="
    end

    def compare_guess(guess)
        show_history(guess)

        if @code == guess
            puts "Bravo! the code was cracked! it was indeed #{code.join}"
            return true
        end

        false
    end

end
