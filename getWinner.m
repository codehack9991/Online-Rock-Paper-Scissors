function [ winner ] = getWinner(player1, player2)
%
    ROCK = 1;
    PAPER = 2;
    SCI = 3;
    LIZARD = 4;
    SPOCK = 5;
    
    winner = 0;%means a TIE
    
    if player1 == ROCK
        if player2 == SCI || player2 == LIZARD
            winner = 1;
        elseif player2 == PAPER || player2 == SPOCK
            winner = 2;
        end
        
    elseif player1 == PAPER
        if player2 == ROCK || player2 == SPOCK
            winner = 1;
        elseif player2 == SCI || player2 == LIZARD
            winner = 2;
        end
        
    elseif player1 == SCI
        if player2 == PAPER || player2 == LIZARD
            winner = 1;
        elseif player2 == ROCK || player2 == SPOCK
            winner = 2;
        end
        
    elseif player1 == LIZARD
        if player2 == PAPER || player2 == SPOCK
            winner = 1;
        elseif player2 == ROCK || player2 == SCI
            winner = 2;
        end
        
    elseif player1 == SPOCK
        if player2 == SCI || player2 == ROCK
            winner = 1;
        elseif player2 == PAPER || player2 == LIZARD
            winner = 2;
        end
    end
    

end

