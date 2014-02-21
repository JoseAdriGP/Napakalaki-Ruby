# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'player'
require_relative 'monster'
require_relative 'card_dealer'
require_relative 'napakalaki'
require_relative 'bad_stuff'
require_relative 'combat_result'
require_relative 'dice'
require_relative 'prize'
require_relative 'treasure'
require_relative 'treasure_kind'
require_relative 'cultist'
require_relative 'cultist_player'
require "singleton" 
module Napakalaki
  class Napakalaki
    attr_accessor :currentMonster, :currentPlayer
    include Singleton
      def initialize() 
        @currentMonster = 2
        @currentPlayer 
        @players = Array.new
        @dealer
      end
    
    def developCombat()
        result = @currentPlayer.combat(@currentMonster)
        if result == LoseAndConvert
          c = dealer.nextCultist
          p = @currentPlayer
          cultp = cultist_player.newCultistPlayer(p, c)
          for player in @players
            if player == @currentPlayer
              @currentPlayer = cultp
              player = cultp
            end
          end 
        end
        @dealer.giveMonsterBack(@currentMonster)
        return result
    end
    
    def discardVisibleTreasure(treasures)
      for i in 0..(treasures.length-1) 
            @currentPlayer.discardVisibleTreasure(treasures[i])
            @dealer.giveTreasureBack(treasures[i])
      end
    end

    def discardHiddenTreasure(treasures)
      for i in 0..(treasures.length -1)
            @currentPlayer.discardHiddenTreasure(treasures[i])
            @dealer.giveTreasureBack(treasures[i])
      end
    end

    def makeTreasuresVisibles(treasures)
      for i in 0..(treasures.length-1)
            @currentPlayer.makeTreasureVisible(treasures[i])
      end
    end

    def buyLevels(visible, hidden)
       canI = @currentPlayer.buyLevels(visible, hidden)
       return canI
    end

    def initGame(players)
      initPlayers(players)
      @dealer = CardDealer.instance
      @dealer.initCards
      nextTurn()
    end
    
    def getCurrentPlayer()
      return @currentPlayer
    end
    
    def getCurrentMonster()
      return @currentMonster
    end
    
    def canMakeTreasureVisible(t)
      return false
    end

    def nextTurn()
      stateOK = nextTurnIsAllowed()
        if stateOK
            
            @currentMonster = @dealer.nextMonster
            @currentPlayer = nextPlayer()
            @dead = @currentPlayer.isDead()
            if(@dead)
                @currentPlayer.initTreasures()
            end
        end
        return stateOK
    end
        

    def nextTurnIsAllowed()
      if(@currentPlayer == nil) 
        return true
      end
      @currentPlayer.validState()
    end

    def endOfGame(result)
      if WinAndWinGame == result 
        return true
      else
        return false
      end
    end
    
    def initPlayers(names)
        for i in 0..(names.length-1)        
            @players << Player.new(names[i])  
            puts (@players[i])
        end
      end 
    def nextPlayer()
      if @currentPlayer == nil then
        #rand(0..names.length-1)
        i = rand(0..@players.length-1)
        @currentPlayer =  @players[i]
      else
        i = @players.index(@currentPlayer)
        @currentPlayer = @players[(i+1)%@players.length]
      end  
    end
  end  
end
