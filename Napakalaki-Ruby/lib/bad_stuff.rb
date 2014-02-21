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
  class BadStuff
    attr_accessor :levels, :nVisibleTreasures, :nHiddenTreasures, :specificHiddenTreasures, :specificVisibleTreasures
    def initialize(text, levels=0, nVisibleTreasures=0, nHiddenTreasures=0, specificHiddenTreasures=Array.new, specificVisibleTreasures=Array.new, death= false)
        @text = text
        @levels = levels
        @nVisibleTreasures = nVisibleTreasures
        @nHiddenTreasures = nHiddenTreasures
        @death = death
        @specificHiddenTreasures = specificHiddenTreasures
        @specificVisibleTreasures = specificVisibleTreasures
    end
    
    def isEmpty() 
        comprobante = true
        if @nVisibleTreasures > 0 || @nHiddenTreasures > 0 || levels > 0 || !@specificHiddenTreasures.empty? || !@specificVisibleTreasures.empty?
            comprobante = false
        end
        return comprobante
    end

    def kills()
    end
    
    #De nuevo el bucle for y la instancia del metodo *******************
    def substractVisibleTreasure(t) 
      if !@specificVisibleTreasures.empty?
            for i in 0..(@specificVisibleTreasures.length-1)
                if(@specificVisibleTreasures[i].class == t.class)
                    @specificVisibleTreasures.delete(i)
                end
            end
      else
            if @nVisibleTreasures > 0
                @nVisibleTreasures = @nVisibleTreasures - 1           
            end
                
      end
    end
    def substractHiddenTreasure(t)
      if !@specificHiddenTreasures.empty?
            for i in 0..(@specificHiddenTreasures.length-1)
                if(@specificHiddenTreasures[i].class == t.class)
                    @specificHiddenTreasures.delete(i)
                end
            end
      else
            if @nHiddenTreasures > 0
                @nHiddenTreasures = @nHiddenTreasures - 1           
            end
      end
    end
    
    def self.newLevelNumberOfTreasures(text, levels, nVisibleTreasures, nHiddenTreasures)
        objeto = self.allocate
        objeto.send(:initialize, text, levels, nVisibleTreasures, nHiddenTreasures)
        objeto
    end
    
    def self.newLevelSpecificTreasures(text, levels, specificHiddenTreasures, specificVisibleTreasures)
        objeto = self.allocate
        objeto.send(:initialize, text, levels, 0, 0,specificHiddenTreasures,specificVisibleTreasures,false)
        objeto
    end    
    
    def self.newDeath(text, death)
        objeto = self.allocate
        objeto.send(:initialize, text, 0, 0, 0,Array.new,Array.new,death)
        objeto
    end

    def adjustToFitTreasureLists(v,h)
        pendingBadStuff       
        visible = Array.new
        oculto = Array.new       
        if @specificHiddenTreasures.length>0
            for i in 0..@specificHiddenTreasures.length-1
                for j in 0..h.size()
                    if @specificHiddenTreasures[i] == v[j].class
                        oculto << @specificHiddenTreasures[i]
                    end
                end        
            end        
        end
        
        if @specificVisibleTreasures.length>0       
            for i in 0..@specificVisibleTreasures.length
                for j in 0..v.size()
                  if @specificVisibleTreasures[i]==v[j].class
                        visible << specificVisibleTreasures[i]
                    end
                end          
            end
        end
        
        if @specificVisibleTreasures.length == 0 && @specificHiddenTreasures.length == 0    
            for i in 0..@specificHiddenTreasures.length && @nVisibleTreasures.length
                oculto << v[i].class
            end
            for i in 0..@specificVisibleTreasures.length && @nHiddenTreasures.length
                visible<< h[i].class
            end            
        end
        
        pendingBadStuff = new BadStuff("BadStuff Personal",0,visible,oculto)
        
        return pendingBadStuff
    end
    
    def myBadStuffIsDeath()
        comprobante = false
        if @death
            comprobante = true
        end
        return comprobante
    end
        
    
    
    def to_s
      "Niveles perdidos #{@levels} \n Numero de tesoros visibles #{@nVisibleTreasures} \n Numero de tesoros ocultos #{@nHiddenTreasures} \n Muerte #{@death} \n Tesoros ocultos #{@specificHiddenTreasures} \n Tesoros visibles #{@specificVisibleTreasures}"
    end
  end
end
