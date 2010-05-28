ENV["RAILS-MARIONET_ENV"] = "test"

require 'rubygems'
require 'active_record'
require 'action_controller'
require 'test/unit'

require 'test/test_case.rb'

require 'marionet'

class Test::Unit::TestCase
  include ActiveSupport::Testing::SetupAndTeardown
  include ActiveRecord::TestFixtures
end
