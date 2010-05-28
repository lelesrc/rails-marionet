require 'rexml/document'
include REXML

class Marionet::Session

  attr_reader :name

  def initialize()
    @creation_time = Time.now
    @name = 'xxxxxx' # XXX: randomize
      
    @_element = Element.new('portlet-session')
    self.set('namespace','_portlet_%s' % @name)
  end
  
  def get(attr)
    @_element.attributes[attr]
  end
  
  def set(attr,value)
    @_element.attributes[attr] = value
  end
  
  def to_xml
    doc = REXML::Document.new
    doc << @_element
    xml = ''
    doc.write xml
    return xml
  end

end