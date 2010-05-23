module Ratp
  class Client
    attr_accessor :origin, :destination, :transport_method
    
    # Options should be given as symbols, except for the origin which 
    # should be a String to be recognized.
    def initialize opts={}
      @url = "http://ratp.info"
      @browser = Celerity::Browser.new
      
      parse_options opts
    end
    
    def parse_options opts
      @origin, @destination = extract_path_and_types opts
      @transport_method = opts[:transport_method] || :any
    end
    
    def fetch
      @browser.goto @url
      @frame = @browser.frame "ratp"
      @frame = @frame.frames.first # grab search frame
      
      @frame.text_field(:name, "adp").value = @origin.location
      @frame.text_field(:name, "aar").value = @destination.location
      
      @frame.radio(:name, "type_dep", @origin.type_as_radio_value).set
      @frame.radio(:name, "type_arr", @destination.type_as_radio_value).set
      
      submit_link = @frame.p(:class, "searchItineraire").links.first
      
      @result_browser = submit_link.click_and_attach
    end
    
    def extract_path_and_types opts
      paths = extract_path  opts
      types = extract_types opts
      
      [
        Position.new(paths.first, types.first),
        Position.new(paths.last,  types.last)
      ]
    end
    
    def extract_types opts
      types = []
      Position.types.each do |type|
        types << type << opts[type] if opts[type]
      end
      
      types
    end
    
    def extract_path opts
      path = []
      opts.each do |key, value|
        path << key << value if key.is_a? String
      end
      
      path
    end
    
    class << self
      def fetch opts={}
        @instance ||= new(opts)
        @instance.fetch
      end
    end
  end
end