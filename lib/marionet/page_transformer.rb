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
      node.text = 'xxxx'
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

    #XML::XSLT.registerExtFunc(@@namespace, "link") do link end

    # Perform XSL transformation on the html (REXML::Document) or (String),
    # with the marionet portlet session (Marionet::Session).
    # Session is a REXML::Element 'portlet-session'.
    def transform(doc,session,stylesheet=:body)
      #logger.debug self.instance.transformer
      # create copy of the transformer attribute from instance. 
      transformer = self.instance.transformer_impl(stylesheet)
      #logger.debug transformer
      transformer.xml = doc
      # Transform.
      # The transformation, possibly due to a bug, mutes the session,
      # so a duplicate has be created.
      transformer.parameters = { 'namespace' => session.get('namespace').dup }
      transformer.serve()
    end

    def logger
      Marionet.logger
    end
  
  end

end