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

class CultistPlayer < Player
  @@totalCultistPlayers = 0
  @myCultistCard
  attr_reader :totalCultistPlayers
  def self.newCultistPlayer (p, c)
    a=super.newPlayer(p)
    a.myCultistCard=c
    @@totalCultistPlayers += 1
    return a
  end
  def getCombatLevel()
    return super.getCombatLevel + myCultistCard.getSpecialValue
  end
  def shouldCombert()
    return false
  end
  def getOponentLevel(m)
    return m.getSpecialValue()
  end 
  def computeGoldCoinsValue(t)
     monedas = 0
        niveles = 0
        for i in 0..(t.length-1)
            monedas += te[i].getGoldCoins()
        end
        monedas = monedas * 2
        niveles = monedas/1000
        return niveles
  end
  def self.getTotalCultistPlayer()
    @@totalCultistPlayers
  end
end

