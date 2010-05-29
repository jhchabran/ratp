module Ratp
  class Path
    attr_accessor :steps
    
    def initialize steps=[]
      @steps = steps
    end
    
    def << step
      @steps << step
    end
    
    def to_s
      "Path : " + @steps.collect { |step| "#{step.class.name} #{step.description}" }.join(" | ")
    end
  end
end