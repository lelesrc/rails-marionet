require 'rexml/document'
include REXML

class Marionet::Session

  attr_reader :name
  attr_reader :element

  def initialize()
    @creation_time = Time.now
    @name = "xxxxxx" # XXX: randomize
      
    @element = Element.new('portlet-session')
    self.set('namespace',"_portlet_#{@name}")
  end
  
  def get(attr)
    @element.attributes[attr]
  end
  
  def set(attr,value)
    @element.attributes[attr] = value
  end
  
  def to_xml
    doc = REXML::Document.new
    doc << @element
    xml = ''
    doc.write xml
    return xml
  end

end