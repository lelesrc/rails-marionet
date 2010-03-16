class Slot
  require 'open-uri'
  require 'hpricot'
  attr_accessor :url, :html, :name, :header, :body
  
  def initialize(url,name)
    @url = url
    @name = name
    begin
      f = open(url)
    rescue
      return false
    else
      f.rewind
      @html = f.readlines.join("\n")
      doc = Hpricot(@html)
      @header = doc.search("head").to_s
      @body = doc.search("body").to_s
      return true
    end
  end
  
  def render
    return "<div class=\"#{self.name}\">#{self.body}</div>"
  end
end