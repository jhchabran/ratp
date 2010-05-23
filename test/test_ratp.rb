require 'helper'

class TestRatp < Test::Unit::TestCase
  should "fetch a path from Alesia to Chatelet" do
    @path = Ratp::Client.fetch("Alesia" => "Chatelet")
    assert @path
  end
end
