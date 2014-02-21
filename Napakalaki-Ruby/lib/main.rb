require_relative 'treasure_kind'
require_relative 'prize'
require_relative 'bad_stuff'
require_relative 'monster'
require_relative 'cultist'
require_relative 'cultist_player'
module Napakalaki
  nombres = {}
  nombres[0] = "Jugador 1"
  nombres[1]= "Jugador 2"
  
  juego = Napakalaki.instance()
  
  juego.initGame(nombres)
  
  juego.endOfGame(WinAndWinGame)
  
end

