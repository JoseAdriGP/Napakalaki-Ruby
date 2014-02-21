# To change this template, choose Tools | Templates
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
  class Prize
    attr_accessor :treasure, :levels
    def initialize (treasures, levels)
      @treasure = treasures
      @levels = levels
    end
    def to_s
      "Tesoros ganados: #{@treasure} \n Niveles ganados: #{@levels}"
    end
  end
end