begin
  require 'active_support/testing/assertions'
rescue
  STDERR.puts 'OOPS'
  raise $!
end
 
require 'active_support/test_case'
 
require 'active_record/fixtures'
require 'active_support/dependencies'
 
class ActiveSupport::TestCase

end