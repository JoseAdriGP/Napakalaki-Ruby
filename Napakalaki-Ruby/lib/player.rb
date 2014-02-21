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
module Napakalaki
  class Player
    attr_accessor :name, :level, :HiddenTreasures, :VisibleTreasures
    def initialize(name)
      @dead
      @name = name
      @level = 0          
      @HiddenTreasures = Array.new
      @VisibleTreasures = Array.new
      #@VisibleTreasures << Treasure.new("Si mi amo", 0, 1, 7, HELMET)
      #@VisibleTreasures << Treasure.new("Si mi amo", 0, 1, 7, NECKLACE)
      @pendingBadStuff
    end

    def isDead()
      @dead  
    end
    
    def getOponentLevel(m)
      return m.combatLevel
    end
    
    #No muy seguro de que asi se llame a la instancia de dice en ruby
    def shouldCombert()
      combertirse = false
      dice = Dice.instance
      combertido = dice.nextNumber()
      if combertido == 6
        combretirse = true
      end
      return combertirse
    end
    
    def self.newPlayer(p)
      p2 = new(p.name)
      p2.level = p.level
      p2.dead = p.dead
      p2.HiddenTreasures = p.HiddenTreasures
      p2.VisibleTreasures = p.VisibleTreasures
      p2.pendingBadStuff = p.pendingBadStuff
      return p2
    end
    
    def getCombatLevel()
      plusTesoros = 0
      encontrado = false
      for i in 0..(@VisibleTreasures.length-1)
        if @VisibleTreasures[i].class == NECKLACE
          print 'Se ha encontrado'
          encontrado = true
        end
      end
        if encontrado == true
          for i in 0..(@VisibleTreasures.length-1)
            plusTesoros = plusTesoros + @VisibleTreasures[i].maxBonus 
          end
          
          plusTesoros = @level + plusTesoros
          return plusTesoros
        else
          for i in 0..(@VisibleTreasures.length-1)
            plusTesoros = plusTesoros + @VisibleTreasures[i].minBonus 
          end
          plusTesoros = @level + plusTesoros
          return plusTesoros
        end
    end
        
    

    def applyPrize(currentMonster)
        nLevels = currentMonster.getLevelsGained()
        incrementLevels(nLevels)
        nTreasures = currentMonster.getTreasuresGained()
        if nTreasures > 0
            dealer = CardDealer.instance
            for i in 0..nTreasures
                @hiddenTreasures << dealer.nextTreasure()
            end
        end
    end

    def combat(m)    
              combatResult
              myLevel = getCombatLevel
              monsterLevel = getOponentLevel(m)
              if myLevel>monsterLevel
                  applyPrize(m)
                  if getLevels()>=10
                      combatResult = WinAndWinGame
                  else
                      combatResult = Win
                  end
              else
                  dice = Dice.instance
                  escape = dice.nextNumber()
                  if escape<5
                      amIDead = m.kills()
                      if amIDead
                          die()
                          combatResult = LoseAndDie
                      else
                          convertirse = shouldCombert()
                          if combertirse
                            combatResult = LoseAndComvert
                          end
                          bad = m.getBadStuff
                          applyBadStuff(bad)
                          combatResult = Lose
                      end
                  end
                  combatResult = LoseAndEscape;
              end
              discardNecklaceVisible();
          return combatResult;  
    end

    def applyBadStuff(bad)
       nLevels = bad.getLevels()
       decrementLevels(nLevels)
       pendingBad = bad.adjustToFitTreasureList(@VisibleTreasures, @HiddenTreasures)
       setPendingBadStuff(pendingBad)
    end

    def makeTreasureVisible(t)
        canI = canMakeTreasureVisible(t)
        if canI
            @VisibleTreasures << t
            @HiddenTreasures.d(t)
        end
    end
    
    def canMakeTreasureVisible(t)
       @comprobante = false       
       if @VisibleTreasures.empty?
            @comprobante = true
       else
           for i in 0..@VisibleTreasures                
                if tre.class == t.class
                    @comprobante = false
                else
                    @comprobante = true
                end        
            end
        end
        return @comprobante
    end    

    def discardVisibleTreasure(t)
        @VisibleTreasures.delete(t)
        if @pendingBadStuff != nil && !@pendingBadStuff.empty?
            @pendingBadStuff.substractVisibleTreasure(t)
        end
        dieIfNoTreasures()
    end

    def discardHiddenTreasure(t)
        @HiddenTreasures.delete(t)
        if @pendingBadStuff != nil && !@pendingBadStuff.empty?
            @pendingBadStuff.substractHiddenTreasure(t)
        end
        dieIfNoTreasures()
    end

    def buyLevels(visible,hidden)
        levelsMayBought = computeGoldCoinsValue(visible)
        levelsMayBought += computeGoldCoinsValue(visible)
        canI = canBuyLevels(levelsMayBought)
        if canI
            incrementLevel(levelsMayBought)
        end
        @VisibleTreasures.clear
        @HiddenTreasures.clear
        dealer = CardDealer.instance
        for i in 0..visible.length
            dealer.giveTreasureBack(visible[i])
        end
        for i in 0..hidden.length
            dealer.giveTreasureBack(hidden[i])
        end
        return canI 
    end

    def validState()
      comprobante = false
        if @pendingBadStuff.empty?
            if @HiddenTreasures.length < 5
                comprobante = true            
            end
        end
        return comprobante
    end

    def initTreasures()
        dealer = CardDealer.instance
        dice = Dice.instance
        bringToLife
        treasure = dealer.nextTreasure
        @HiddenTreasures << treasure
        number = dice.nextNumber
        if number < 6
            treasure = dealer.nextTreasure()
            @HiddenTreasures << treasure
        end
        if number == 6
            treasure = dealer.nextTreasure()
            @HiddenTreasures << treasure
        end
    end

    def hasVisibleTreasures()
      comprobante = false
        if @VisibleTreasures.length != 0
            comprobante = true
        end
        return comprobante
    end
    
    def to_s
      @name
    end
    def howManyVisibleTreasures(tKind)
        contador = 0
        for i in 0..(@VisibleTreasures.length-1)
            if @VisibleTreasures[i].class == tKind.class
                contador = contador +1
            end
        end
        return contador       
    end
    private
      def bringToLife()
        @dead = false
      end
    private
      def incrementLevels(i)
        @level = @level + i
      end
    private
      def decrementLevels(i)
        @level = @level - i
      end
    private
      def setPendingBadStuff(b)
        @pendingBadStuff = b
      end
    private
      def die()
        setLevel(1)
        dealer = CardDealer.instance
        for i in 0..@VisibleTreasures.length
            dealer.giveTreasureBack(@VisibleTreasures[i])
        end
        visibleTreasures.clear()
        for i in 0..@HiddenTreasures.length
            dealer.giveTreasureBack(@HiddenTreasures.get(i));
        end
        @HiddenTreasures.clear
        dieIfNoTreasures()
      end
    private 
      def discardNecklaceIfVisible()
        for i in 0..(@VisibleTreasures.length-1)
                if @VisibleTreasures[i].class == NECKLACE
                    discardVisibleTreasure(@VisibleTreasures[i]);                
                end
        end
      end 
    private
      def dieIfNoTreasures()
        if @VisibleTreasures.empty?
          if @HiddenTreasures.empty?
                @dead = true;            
          end
        end
      end
    private    
      def computeGoldCoinsValue(t)
        monedas = 0
        niveles = 0
        for i in 0..(t.length-1)
            monedas += te[i].getGoldCoins()
        end
        niveles = monedas/1000
        return niveles
      end      
    private
      def canIBuyLevels(l)   
        levelaux
        comprobante = false
        levelaux = @level + l
        if levelaux < 10
            comprobante = true
        end
        return comprobante
      end
  end
end
