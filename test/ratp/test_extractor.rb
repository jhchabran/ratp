require 'helper'

class TestExtractor < Test::Unit::TestCase
  def results_page
    @results_page ||= Ratp::Client.new("Alesia" => "Balard", :station => :station).fetch_results_page
  end
  
  should "extractor data from a celerity browser instance attached to the result page" do
    @extractor = Ratp::Extractor.new results_page
    @extractor.read
    
    #puts @extractor.raw_output
    puts @extractor.path
  end
end