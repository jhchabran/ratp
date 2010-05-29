module Ratp
  class Step
    attr_reader :description 
    
    def recognize text
      raise "Not Implemented"
    end
    
    def self.recognize text
      transition = Transition.new
      movement   = Movement.new
      
      if transition.recognize text
        transition
      elsif movement.recognize text
        movement
      end
    end
  end
  
  class Transition < Step
    
    def recognize text
      text.match(/Allez jusqu'à : (.*)\s*/u) || text.match(/Correspondance à : (.*)\s*/u)
      @decription = $1
    end
  end
  
  class Movement < Step
    def recognize text
      text.match(/Direction : (.*)\s*/u) || text.match(/de : (.*)\s*/u)
      @description = $1
    end
  end
end
