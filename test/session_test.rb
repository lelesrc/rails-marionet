require File.dirname(__FILE__) + '/test_helper'

class SessionTest < Test::Unit::TestCase
  
  def setup
  end

  def test_session
    session = Marionet::Session.new
    self.assert(session.name)
    self.assert(session.to_xml)
  end

end  
