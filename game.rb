require_relative 'board'
require_relative 'player'

class Game
    attr_accessor :turn_num, :game_on, :human_code_breaker, :total

    def initialize(val,player,board)
        @turn_num = 1
        @total = 12
        @game_on = true
        @human_code_breaker = val
        @player = player
        @board = board
        @last_guess = nil
    end

    def self.choose_role
        loop do
            puts "Choose your role:"
            puts "1) Code breaker (you guess the computer's code)"
            puts "2) Code maker (the computer guesses your code)"
            choice = gets.chomp
            return true  if choice == "1"
            return false if choice == "2"
            puts "Please enter 1 or 2."
        end
    end

    # asks until exactly 4 digits are entered, returns them as an array
    def self.read_code(prompt)
        loop do
            puts prompt
            input = gets.chomp
            return input.chars.map(&:to_i) if input.match?(/\A\d{4}\z/)
            puts "Enter exactly 4 digits."
        end
    end

    def print_turn
        puts "Turn #{@turn_num}: #{@total - @turn_num + 1} more attempts.. "
    end

    def get_player_input
        print_turn()
        guess = Game.read_code("enter numbers one after the other:")
        @turn_num += 1
        guess
    end

    def get_computer_guess
        print_turn()
        score = @last_guess && Board.score(@last_guess, @board.code)
        guess = @player.break_code(@last_guess, score)
        puts "Computer guesses: #{guess.join}"
        @last_guess = guess
        @turn_num += 1
        guess
    end

    def compare_guess(guess)

       correct_guess = @board.compare_guess(guess)

       if correct_guess
        @game_on = false
       end

    end

    def check_game_end
        if @turn_num > @total
            @game_on = false
            puts "Game Over..;( The code was: #{@board.code.join}"
        end
    end

    def game_start
        while @game_on
            guess = @human_code_breaker ? get_player_input() : get_computer_guess()
            compare_guess(guess)
            check_game_end() if @game_on
        end
    end

end


if __FILE__ == $0
    loop do
        human_breaks = Game.choose_role

        if human_breaks
            breaker = Player.new("Breaker", "Bob")
            code = Player.new.make_code
        else
            breaker = Player.new("Breaker")
            code = Game.read_code("Enter your secret 4-digit code:")
        end

        Game.new(human_breaks, breaker, Board.new(code)).game_start

        puts "Play again? (y/n)"
        break unless gets.chomp.downcase == "y"
    end
end
