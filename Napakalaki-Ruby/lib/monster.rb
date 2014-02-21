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
  class Monster
    include Card
    attr_accessor :name, :combatLevel, :bc, :levelChangeAgainstCultistPlayer
    #He puesto lo de "=0" en el initialize de la clase siguiendo un consejo de la prrofe, pero no creo que funcione sinceramente 
    def initialize(name, combatLevel, price, bc, levelChangeAgainstCultistPlayer=0)
      @name = name
      @combatLevel = combatLevel
      @price = price
      @bc = bc
      @levelChangeAgainstCultistPlayer = levelChangeAgainstCultistPlayer
    end
    
    def getLevelsGained() 
      @price.getLevels()
    end
    
    def getTreasuresGained()
      @price.getTreasures()
    end
    
    def kills()
        comprobante = false
        if @bc.getDeath()
            comprobante = true
        end
        return comprobante
    end
    
    def to_s
      " Nombre #{@name} \n Nivel de monstruo #{@combatLevel} \n #{@bc} \n #{@price}"
    end
    
    def getBasicValue()
      return getLevel()
    end
    
    def getSpecialValue()  
      return getLevel()+levelChangeAgainstCultistPlayer()
    end
    
  end
end
