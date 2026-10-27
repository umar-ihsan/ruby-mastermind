require_relative 'board'

# Maker and Breaker are the two roles. The human or the computer can be either.

class Player
    attr_accessor :name, :role, :code

    def initialize(role= "Maker", name= "computer" )
        @name = name
        @role =  role
        @code = []
    end

    def make_code
        @code = Array.new(4) { rand(0..9) }
    end

    # Knuth-style computer guesser: keep only the codes consistent with every
    # score so far, then pick the candidate whose worst-case score group is
    # smallest (minimax, restricted to remaining candidates for speed).
    def break_code(last_guess = nil, last_score = nil)
        @candidates ||= (0..9999).map { |n| format("%04d", n).chars.map(&:to_i) }

        return [0, 0, 1, 1] if last_guess.nil?

        @candidates.select! { |c| Board.score(last_guess, c) == last_score }
        return @candidates.first if @candidates.size <= 2

        @candidates.min_by do |g|
            @candidates.map { |c| Board.score(g, c) }.tally.values.max
        end
    end
end
