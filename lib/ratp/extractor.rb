module Ratp
  class Extractor
    attr_reader :path, :raw_output
    
    def initialize browser
      @browser = browser
    end
    
    def read
      @path = read_results_table @browser.tables.first
    end
    
    def read_results_table table
      steps       = []
      stations    = []
      indications = []
      dates       = []
      duration    = []
      maps        = []
      
      @raw_output = "\n"
      @raw_output << "#{'steps'.center(20)} | #{'stations'.center(20)} | #{'indications'.center(60)} | #{'dates'.center(20)} | #{'duration'.center(20)} | #{'maps'.center(20)}\n"
      
      table.tbodies.first.rows.each do |row|
        next if row.child_cell(6).text == "Plan"
        
        steps       << row.child_cell(1).text.gsub("\n"," ")
        stations    << row.child_cell(2).text.gsub("\n"," ")
        indications << row.child_cell(3).text.gsub("\n"," ")
        dates       << row.child_cell(4).text.gsub("\n"," ")
        duration    << row.child_cell(5).text.gsub("\n"," ")
        maps        << row.child_cell(6).text.gsub("\n"," ")
        
     
        @raw_output << "#{steps.last.center(20)} | #{stations.last.center(20)} | #{indications.last.center(60)} | #{dates.last.center(20)} | #{duration.last.center(20)} | #{maps.last.center(20)}\n"
      end
      
      path = Path.new
      
      steps.length.times do |index|
        path << Step.recognize(indications[index])
      end
      
      path
    end
    
    class << self
      def read browser
        new(browser).read
      end
    end
  end
end