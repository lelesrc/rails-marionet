require "xml/xslt"
require "singleton"

# Singleton class, where the shared instance loads XSL stylesheets only once. 
class Marionet::PageTransformer
  include Singleton
  
  @@namespace = 'http://github.com/youleaf/rails-marionet'
  attr_reader :stylesheets
  
  def initialize()
    @stylesheets = {}
    @stylesheets.update( { :body => Document.new( File.new( File.join(
      File.dirname(__FILE__),'..','xsl','body.xsl'))) } ) 
    @stylesheets.update( { :test => Document.new( File.new( File.join(
      File.dirname(__FILE__),'..','xsl','test.xsl'))) } )

=begin
        ns = etree.FunctionNamespace('http://github.com/youleaf/django-marionet')
        ns.prefix = "marionet"
        ns['link'] = PageProcessor.link
        ns['image'] = PageProcessor.image
        ns['href'] = PageProcessor.href
        ns['form'] = PageProcessor.form
=end
  end
  
  def transformer_impl(stylesheet)
    impl = XML::XSLT.new()
    impl.xsl = @stylesheets[ stylesheet ]
    return impl
  end

  class << self

    #XML::XSLT.registerExtFunc(@@namespace, "link") do link end

    # Perform XSL transformation on the html (REXML::Document) or (String),
    # with the marionet portlet session (Marionet::Session).
    # Session is a REXML::Element 'portlet-session'.
    def transform(doc,session,stylesheet=:body)
      #logger.debug self.instance.transformer
      # create copy of the transformer attribute from instance. 
      # XXX: stupid enough to remember it would be useful to return a Proc here
      transformer = self.instance.transformer_impl(stylesheet)
      #logger.debug transformer
      transformer.xml = doc
      # XXX: set session parameters
      # transform
      transformer.parameters = { 'namespace' => session.get('namespace') }
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