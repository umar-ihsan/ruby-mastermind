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
    end

    def get_player_input
            puts "Turn #{@turn_num}: #{@total - @turn_num + 1} more attempts.. "
            puts "enter numbers one after the other:"
            guess = gets.chomp.chars.map(&:to_i)
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
            puts "Game Over..;( The code was: #{@board.code}"
        end
    end

    def game_start
        if @human_code_breaker
            while @game_on
                
                guess = get_player_input()
                compare_guess(guess)
                check_game_end()
            end
        else
            puts "Computer code guesser part is yet to be implemented"
        end
    end

end


if __FILE__ == $0
    player = Player.new("Breaker", "Bob")
    player2 = Player.new()
    code = player2.make_code()
    board = Board.new(code)
    game = Game.new(true, player, board)
    game.game_start()
end