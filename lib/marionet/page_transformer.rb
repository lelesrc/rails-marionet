require "xml/xslt"
require "singleton"

# Singleton class, where the shared instance loads XSL stylesheets only once. 
class Marionet::PageTransformer
  include Singleton
  
  @@namespace = 'http://github.com/youleaf/rails-marionet'
  attr_reader :stylesheets
  
  def initialize()
    body = Document.new( File.new( File.join(
      File.dirname(__FILE__),'..','xsl','body.xsl')))
    test = Document.new( File.new( File.join(
      File.dirname(__FILE__),'..','xsl','test.xsl')))
    @stylesheets = { 
      :body => body,
      :test => test
    }
  end

  # link
  XML::XSLT.registerExtFunc(@@namespace, 'link') do |nodes,session|
    logger.debug('link transformation')
    logger.debug(session)
    nodes.each do |node|
      logger.debug(node)
      href = node.attributes['href']
      unless href
        next
      end
      
      if session[0].attributes['base']
        # XXX: rewrite base
      end
      
      #url = Portlet::Url.render_url()
      url = 'http://new-url'
      
      node.attributes['href'] = url
    end
    nodes
  end
  
  # image
  
  # href
  
  # form

  # Create a new transformer instance, from the static list of cached stylesheets.
  def transformer_impl(stylesheet)
    impl = XML::XSLT.new()
    impl.xsl = @stylesheets[ stylesheet ]
    return impl
  end
  
  def logger
    Marionet.logger
  end

  class << self

    # Perform XSL transformation on the html (REXML::Document) or (String),
    # with the marionet portlet session (Marionet::Session).
    # Session is a REXML::Element 'portlet-session'.
    def transform(doc,session,stylesheet=:body)
      #logger.debug self.instance.transformer
      # create copy of the transformer attribute from instance. 
      transformer = self.instance.transformer_impl(stylesheet)
      #logger.debug transformer

      # append session to the document
      head = XPath.first(doc,'//html')
      if head
        head << session.element
      end

      # prepare transformer with document
      transformer.xml = doc

      # transform
      transformer.serve()
    end

    def logger
      Marionet.logger
    end
  
  end

end