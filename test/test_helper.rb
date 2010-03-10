ENV["RAILS-MARIONET_ENV"] = "test"

require 'rubygems'
require 'active_record'
require 'action_controller'
require 'test/unit'

require 'db_connection'

require 'test/test_case.rb'

class Test::Unit::TestCase
  include ActiveSupport::Testing::SetupAndTeardown
  include ActiveRecord::TestFixtures
end