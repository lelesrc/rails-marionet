module Marionet
  VERSION = '0.0.0'

  def self.logger
    Logger.new(STDOUT)
  end

end

this_file = File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__
this_dir = File.dirname(File.expand_path(this_file))

load File.join(this_dir, 'httpclient.rb')
require File.join(this_dir, 'marionet', 'slot')
require File.join(this_dir, 'marionet', 'portlet')
require File.join(this_dir, 'marionet', 'session')
require File.join(this_dir, 'marionet', 'page_transformer')

