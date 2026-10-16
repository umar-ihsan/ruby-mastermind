# starting out we will assume the code breaker is human and then later
# on i'll add the logic to enable humans to create code and then after
# the to allow computer to attempt to break the code

# Maker and Breaker will be the two roles

class Player
    attr_accessor :name, :role, :code

    def initialize(role, name= "computer" )
        @name = name
        @role =  role
        @code = []
    end

    def make_code
        if role == "Breaker"
            return "My role is to guess the Code"
        end
        
        4.times do |i|
            @code[i] = rand(0..9)
        end

    end

    def break_code
    end
end

        

 


