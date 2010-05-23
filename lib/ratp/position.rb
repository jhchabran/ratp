module Ratp
  class Position
    attr_accessor :location, :type
  
    def initialize location, type
      @location, @type = location, type
    end
  
    def type_as_radio_value
      Position.types_as_radio_values[type]
    end
    
    def self.types
      types_as_radio_values.keys
    end
    
    def self.types_as_radio_values
      {
        :address => 'RUE',
        :station => 'ARRET',
        :place   => 'LIEU'
      }
    end
  end
end