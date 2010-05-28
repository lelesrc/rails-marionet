require File.dirname(__FILE__) + '/test_helper'

require "xml/xslt"
require "rexml/document"
include REXML

class PageTransformerTest < Test::Unit::TestCase
  
  def setup
    @xslt = XML::XSLT.new( )
    @session = Marionet::Session.new
  end
  
  def teardown
    @session = nil
  end

  def test_xslt
    xml = <<EOF
<?xml version="1.0" encoding="UTF-8"?> 
<test>This is a test file</test>
EOF
    doc = Document.new xml
    out = Marionet::PageTransformer.transform(doc,@session,:test)
    self.assert_equal(out,"<?xml version=\"1.0\"?>\nThis is a test file\n")
    self.assert_nil(Marionet::PageTransformer.instance.transformer_impl(:test).xml)
  end

  def test_transform_string_link
    html = <<EOF
    <html>
      <body>
        <a href="http://url">Link test</a>
      </body>
    </html>
EOF
    doc = Document.new html
    #p doc
    session = @session.dup
    out = Marionet::PageTransformer.transform(doc,@session)
    #p out
    #self.assert(@session.equal?(session))
    outdoc = Document.new out
    portlet_element = XPath.first(outdoc, "//div")
    self.assert_equal(portlet_element.attributes['id'], @session.get('namespace'))
  end

end  
