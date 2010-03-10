require 'rake'
require 'rake/testtask'
   
desc 'Default: run unit tests.'
task :default => :test
 
desc 'Test the rails-marionet gem.'
Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end