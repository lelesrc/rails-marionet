module Marionet
  VERSION = '0.0.0'
end

this_file = File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__
this_dir = File.dirname(File.expand_path(this_file))

require File.join(this_dir, 'httpclient')
require File.join(this_dir, 'marionet', 'slot')
require File.join(this_dir, 'marionet', 'portlet')

