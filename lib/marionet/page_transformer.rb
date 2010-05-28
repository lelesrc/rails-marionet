require "xml/xslt"

# Singleton class, where the shared instance loads XSL stylesheets only once. 
class Marionet::PageTransformer
  include Singleton
  
  @@namespace = 'http://github.com/youleaf/rails-marionet'
  attr_reader :body
  attr_reader :test
  
  def initialize()
    @body = XML::XSLT.new(  )
    @body.xsl = Document.new File.new File.join(File.dirname(__FILE__),'..','xsl','body.xsl')
    @test = XML::XSLT.new(  )
    @test.xsl = Document.new File.new File.join(File.dirname(__FILE__),'..','xsl','test.xsl')
=begin
        ns = etree.FunctionNamespace('http://github.com/youleaf/django-marionet')
        ns.prefix = "marionet"
        ns['link'] = PageProcessor.link
        ns['image'] = PageProcessor.image
        ns['href'] = PageProcessor.href
        ns['form'] = PageProcessor.form
=end
  end

  class << self

    #XML::XSLT.registerExtFunc(@@namespace, "link") do link end

    # Perform XSL transformation on the html (REXML::Document) or (String),
    # with the marionet portlet session (Marionet::Session).
    # Session is a REXML::Element 'portlet-session'.
    def transform(doc,session,stylesheet=nil)
      #logger.debug self.instance.transformer
      # create copy of the transformer attribute from instance. 
      # XXX: stupid enough to remember it would be useful to return a Proc here
      transformer = 
        if stylesheet == :test
          self.instance.test
        else
          self.instance.body
        end
      logger.debug transformer
      transformer.xml = doc
      # XXX: set session parameters
      # transform
      transformer.serve()
    end

    def link()
      logger.debug('link transformation')
      'link comes here'
    end
    
    def logger
      Marionet.logger
    end
  
  end

end