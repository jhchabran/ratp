require 'helper'

class TestClient < Test::Unit::TestCase
  should "fetch result page" do
    assert Ratp::Client.new("Alesia" => "Stalingrad", :station => :station).fetch_results_page
  end
end