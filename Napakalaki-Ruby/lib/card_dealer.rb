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
  class CardDealer
    include Singleton
    def initialize()
      @unusedMonsters = Array.new
      @usedMonsters = Array.new
      #En realidad es @unusedTreasures, la ultima letra es una s no una d
      @unusedTreasured = Array.new
      @usedTreasured = Array.new #idem al anterior
      
      @unusedCultist = Array.new
      @usedCultist = Array.new
      
    end
      def initTreasureCardDeck()
        @unusedTreasured << Treasure.new("Si mi amo", 0, 4, 7, HELMET)
        @unusedTreasured << Treasure.new("Botas de investigacion", 600, 3, 4, SHOE)
        @unusedTreasured << Treasure.new("Capucha de Cthulhu", 500, 3, 5, HELMET)
        @unusedTreasured << Treasure.new("A prueba de babas", 400, 2, 5, ARMOR)
        @unusedTreasured << Treasure.new("Botas de lluvia acida", 800, 1, 1, BOTHHAND)
        @unusedTreasured << Treasure.new("Casco minero", 400, 2, 4, HELMET)
        @unusedTreasured << Treasure.new("Ametralladora Thompson", 600, 4, 8, BOTHHAND)
        @unusedTreasured << Treasure.new("Camiseta de la UGR", 100, 1, 7, ARMOR)
        @unusedTreasured << Treasure.new("Clavo de rail ferroviario", 400, 3, 6, ONEHAND)
        @unusedTreasured << Treasure.new("Cuchillo de sushi arcano", 300, 2, 3, ONEHAND)
        @unusedTreasured << Treasure.new("Fez alopodo", 700, 3, 5, HELMET)
        @unusedTreasured << Treasure.new("Hacha prehistorica", 500, 2, 5, ONEHAND)
        @unusedTreasured << Treasure.new("El aparato del Pr. Tesla", 900, 4, 8, ARMOR)
        @unusedTreasured << Treasure.new("Gaita", 500, 4, 5, BOTHHAND)
        @unusedTreasured << Treasure.new("Insecticida", 300, 2, 3, ONEHAND)
        @unusedTreasured << Treasure.new("Escopeta de 3 canones", 700, 4, 6, BOTHHAND)
        @unusedTreasured << Treasure.new("Garabato mistico", 300, 2, 2, ONEHAND)
        ## Bonus mayor en mister T
        @unusedTreasured << Treasure.new("La fuerza de Mr. T", 1000, 0, 0, NECKLACE)
        @unusedTreasured << Treasure.new("La rebeca metalica", 400, 2, 3, ARMOR)
        @unusedTreasured << Treasure.new("Mago de los antiguos", 200, 3, 4, ONEHAND)
        @unusedTreasured << Treasure.new("Necro-playboycon", 300, 3, 5, ONEHAND)
        @unusedTreasured << Treasure.new("Lanzallamas", 800, 4, 8, BOTHHAND)
        @unusedTreasured << Treasure.new("Necro-comicon", 100, 1, 1, ONEHAND)
        @unusedTreasured << Treasure.new("Necronomicon", 800, 5, 7, BOTHHAND)
        @unusedTreasured << Treasure.new("Linterna a 2 manos", 400, 3, 6, BOTHHAND)
        @unusedTreasured << Treasure.new("Necro-gnomicon", 200, 2, 4, ONEHAND)
        @unusedTreasured << Treasure.new("Necrotelecom", 300, 2, 3, HELMET)
        @unusedTreasured << Treasure.new("Porra preternatural", 200, 2, 3, ONEHAND)
        @unusedTreasured << Treasure.new("Tentaculo de pega", 200, 0, 1, HELMET)
        @unusedTreasured << Treasure.new("Zapato deja-amigos", 500, 0, 1, SHOE)
        @unusedTreasured << Treasure.new("Shogulador", 600, 1, 1, BOTHHAND)
        @unusedTreasured << Treasure.new("Varita de atizamiento", 400, 3, 4, ONEHAND) 
      end
      def initMonsterCardDeck()
        prize = Prize.new(4,1)
        badStuff = BadStuff.newLevelNumberOfTreasures('Pierdes 5 niveles y 3 tesoros visibles',5 , 3, 0)
        @unusedMonsters << Monster.new('El rey de rosa ',13,prize,badStuff)
        
        prize = Prize.new(2,1)
        badStuff = BadStuff.newLevelSpecificTreasures('Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta',0,[ONEHAND],[ONEHAND])
        @unusedMonsters<< Monster.new('Angeles de la noche ibicenca ', 14, prize,badStuff)
        
        prize = Prize.new(1,1)
        badStuff = BadStuff.newLevelSpecificTreasures('Embobados con el lindo primigenio, te descartas de tu casco visible',0,[HELMET],0)
        @unusedMonsters<< Monster.new('Chibithulhu ', 2, prize,badStuff)
        
        prize = Prize.new(1,1)
        badStuff = BadStuff.newLevelSpecificTreasures('El primordial bostezo contagioso. Pierdes el calzado visible',0,[SHOE],0)
        @unusedMonsters<< Monster.new('El sopor de Dunwich ', 2, prize,badStuff)
        
        prize = Prize.new(3,1)
        #/*A tener en cuenta dependiendo de los tesoros del jugador*/    
        badStuff = BadStuff.newLevelNumberOfTreasures('Pierdes todos tus tesoros visibles',0 , 0, 0)
        @unusedMonsters<< Monster.new('El gorron en el umbral ', 10, prize,badStuff)
        
        prize = Prize.new(2,1)
        badStuff = BadStuff.newLevelSpecificTreasures('Pierdes la armadura visible',0 , [ARMOR], 0)
        @unusedMonsters<< Monster.new('H.P. Munchcraft ', 6, prize,badStuff)
        
        prize = Prize.new(1,1)
        badStuff = BadStuff.newLevelSpecificTreasures('Sientes bichos bajo la ropa. Descarta la armadura visible',0 , [ARMOR], 0)
        @unusedMonsters<< Monster.new('Bichgooth ', 2, prize,badStuff)
        
        prize = Prize.new(1,1)
        badStuff = BadStuff.newLevelNumberOfTreasures('Toses los pulmones y pierdes 2 niveles',2 , 0, 0)
        @unusedMonsters<< Monster.new('La que redacta en las tinieblas ', 2, prize,badStuff)
        
        prize = Prize.new(2,1)
        badStuff = BadStuff.newDeath('Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estas muerto',true )
        @unusedMonsters<< Monster.new('Los hondos ', 8, prize,badStuff)
        
        prize = Prize.new(2,1)
        badStuff = BadStuff.newLevelNumberOfTreasures('La quinta directiva primaria te obliga a perder 2 niveles y un tesoro 2 manos visible',2 , [BOTHHAND], 0)
        @unusedMonsters<< Monster.new('Roboggoth ', 8, prize,badStuff)
        
        prize = Prize.new(3,1)
        badStuff = BadStuff.newDeath('No le hace gracia que pronuncien mal su nombre. Estas muerto', true)
        @unusedMonsters<< Monster.new('Yskhtihyssg-Goth ', 12, prize,badStuff)
        
        prize = Prize.new(1,1)
        badStuff = BadStuff.newLevelNumberOfTreasures('Da mucho asquito. Pierdes 3 niveles.',3 , 0, 0)
        @unusedMonsters<< Monster.new('Pollipolipo volante ', 3, prize,badStuff)
        
        prize = Prize.new(2,1)
        badStuff = BadStuff.newLevelNumberOfTreasures('Pierdes 2 niveles y 2 tesoros ocultos.',2 , 0, 2)
        @unusedMonsters<< Monster.new('Semillas Cthulhu ', 4, prize,badStuff)
        
        prize = Prize.new(1,1)
        badStuff = BadStuff.newLevelSpecificTreasures('Te asusta en la noche.Pierdes un casco visible.',0 , [HELMET], 0)
        @unusedMonsters<< Monster.new('El espia ', 5, prize,badStuff)
        
        prize = Prize.new(2,1)
        badStuff = BadStuff.newLevelSpecificTreasures('Pierdes tu armadura visible y otra oculta',0 , [ARMOR], [ARMOR])
        @unusedMonsters<< Monster.new('Byankhees de bonanza ', 8, prize,badStuff)
        
        prize = Prize.new(2,1)
        badStuff = BadStuff.newLevelSpecificTreasures('Te intentas escaquear. Pierdes una mano visible.',0 ,  [ONEHAND],0)
        @unusedMonsters<< Monster.new('Dameargo ', 1, prize,badStuff)
        
        prize = Prize.new(4,1)
        badStuff = BadStuff.newDeath('La familia te atrapa. Estas muerto.', true)
        @unusedMonsters<< Monster.new('Familia feliz ', 1, prize,badStuff)
        
        prize = Prize.new(1,1)
        badStuff = BadStuff.newLevelNumberOfTreasures('Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles.', 2, 5, 0)
        @unusedMonsters<< Monster.new('El Lenguas ', 20, prize,badStuff)
        # Son todos los tesoros de la manos. Para mas adelante
        
        prize = Prize.new(1,1)
        badStuff = BadStuff.newLevelNumberOfTreasures('Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos.', 3, 0, 0)
        @unusedMonsters<< Monster.new('Bicefalo ', 20, prize,badStuff)
        
        prize = Prize.new(3,1)
        badStuff = BadStuff.newLevelNumberOfTreasures('Pierdes 1 mano visible', 0, [ONEHAND], 0)
        @unusedMonsters<< Monster.new('El mal indecible impronunciable ', 10, prize,badStuff, -2) 
      
            #/*A tener en cuenta dependiendo de los tesoros del jugador*/  
        prize = Prize.new(2,1)
        badStuff = BadStuff.newLevelNumberOfTreasures('Pierdes tus tesoros visibles. Jajaja', 0, 0, 0)
        @unusedMonsters<< Monster.new('Testigos Oculares ', 6, prize,badStuff, 2) 
        
        prize = Prize.new(2,5)
        badStuff = BadStuff.newLevelNumberOfTreasures('Hoy no es tu dia de suerte. Muerte', true)
        @unusedMonsters<< Monster.new('El gran Cthulhu ', 20, prize,badStuff, 4) 
        
        prize = Prize.new(2,1)
        badStuff = BadStuff.newLevelNumberOfTreasures('Tu gobierno te recorta 2 niveles', 2, 0, 0)
        @unusedMonsters<< Monster.new('Serpiente Político ', 8, prize,badStuff, 2) 
        
        # No estoy seguro de como meter que se pierden casco y armadura visible a la vez
        prize = Prize.new(1,1)
        badStuff = BadStuff.newLevelNumberOfTreasures('Pierdes tu casco y tu armadura visible. Pierdes tus manos ocultas', 0, [HELMET, ARMOR], [ONEHAND],+5)
        @unusedMonsters<< Monster.new('Felpuggoth ', 2, prize,badStuff, 2) 
        
        prize = Prize.new(4,2)
        badStuff = BadStuff.newLevelNumberOfTreasures('Pierdes 2 niveles', 2, 0, 0)
        @unusedMonsters<< Monster.new('Shoggoth ', 16, prize,badStuff, -4) 
        
        prize = Prize.new(1,1)
        badStuff = BadStuff.newLevelNumberOfTreasures('Pintalabios negro. Pierdes 2 niveles', 2, 0, 0)
        @unusedMonsters<< Monster.new('Lolitagooth ', 2, prize,badStuff, 3) 
        
        
      end

      def shuffleTreasures()
        @unusedTreasured.shuffle
      end
      def shuffleMonster()
        @unusedMonsters.shuffle
      end

    def nextTreasure()#Problemas con las instancias de los metodos en Ruby*********
      if @unusedTreasured.length == 0
            @unusedTreasured = @usedTreasures
            @usedTreasured = Array.new
            shuffleTreasures()
      end 
        posicion = @unusedTreasures.length - 1
        tre = @unusedTreasures[posicion]
        giveTreasureBack(tre)
        @unusedTreasures.delete(tre)
        return tre
    end

    def nextMonster()
      
      if @unusedMonsters.length == 0
            @unusedMonsters = @usedMonsters
            @usedMonsters = Array.new
            shuffleMonsters()
      end    
        posicion = @unusedMonsters.length - 1 
        mon = @unusedMonsters[posicion]
        giveMonsterBack(mon)
        @unusedMonsters.delete(mon)
        return mon
    end

    def giveTreasureBack(t)
      @usedTreasures << t
    end

    def giveMonsterBack(m)  
      @usedMonsters << m
    end

    def initCards()
      initTreasureCardDeck
      initMonsterCardDeck
      initCultistCardDeck
    end
    def nextCultist()
      if @unusedCultist.length == 0
            @unusedCultist = @usedCultist
            @usedCultist = Array.new
            shuffleMonsters()
      end    
        posicion = @unusedCultist.length - 1 
        mon = @unusedCultist[posicion]
        giveMonsterBack(mon)
        @unusedCultist.delete(mon)
        return mon
    end
    
    private
    def initCultistCardDeck() 
      @unusedCultist << Cultist.new('Sectario1',1)
      @unusedCultist << Cultist.new('Sectario2',2)
      @unusedCultist << Cultist.new('Sectario3',1)
      @unusedCultist << Cultist.new('Sectario4',2)
      @unusedCultist << Cultist.new('Sectario5',1)
      @unusedCultist << Cultist.new('Sectario6',1)
      
          
    end
    def shuffleCultist()
        @unusedCultist.shuffle
    end
  end
end
