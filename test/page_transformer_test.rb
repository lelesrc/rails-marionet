require File.dirname(__FILE__) + '/test_helper'

require "xml/xslt"
require "rexml/document"
include REXML

class PageTransformerTest < Test::Unit::TestCase
  
  def setup
    @xslt = XML::XSLT.new( )
    @namespace = "__TEST_PORTLET__"
    @session = Marionet::Session.new
  end

  def test_xslt
    xml = <<EOF
<?xml version="1.0" encoding="UTF-8"?> 
<test>This is a test file</test>
EOF
    doc = Document.new xml
    out = Marionet::PageTransformer.transform(doc,@session,:test)
    self.assert_equal(out,"<?xml version=\"1.0\"?>\nThis is a test file\n")
  end

=begin
  def test_transform_string_link
    html = <<EOF
    <html>
      <body>
        <a href="http://url">Link test</a>
      </body>
    </html>
EOF
    doc = Document.new html
    p doc
    out = Marionet::PageTransformer.transform(doc,@session)
    p out
  end
=end
end  
