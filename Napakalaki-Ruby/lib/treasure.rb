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
  class Treasure
    include Card
    attr_accessor :name, :goldCoins, :minBonus, :maxBonus, :type
    def initialize(n,g,min,max,t)
      @name = n
      @goldCoins = g
      @minBonus = min
      @maxBonus = max
      @type = t
    end
    
    def getBasicValue()  
      return @minBonus
    end
    
    def getSpecialValue()
      return @maxBonus
    end

  end
end
