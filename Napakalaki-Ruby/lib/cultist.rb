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
require_relative 'cultist_player'
require_relative 'card_dealer'

class Cultist
  include Card
  def initialize (name, gainedLevels)
    @name = name
    @gainedLevels = gainedLevels
  end
  
  attr_accesor :name, :gainedLevels
  
  def getBasicValue()
    return @gainedLevels
  end
  
  def getSpecialValue()
    a = getBasicValue()*cultist_player.getTotalCultistPlayer()
    return a
  end
  
  
end
