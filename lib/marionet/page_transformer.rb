require "xml/xslt"

class Marionet::PageTransformer
  include Singleton
  
  attr_reader :transformer
  
  def initialize()
    @transformer = XML::XSLT.new( )
    @transformer.xsl = File.join(File.dirname(__FILE__),'..','xsl','body.xsl')  
  end
  
  class << self
  
    def transform(html,session)
      logger.debug self.instance.transformer
    end
    
    def logger
      Marionet.logger
    end
  
  end

end