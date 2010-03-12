class Slot
  require 'open-uri'
  require 'hpricot'
  attr_accessor :url, :html
  
  def initialize(url)
    @url = url
    begin
      f = open(url)
    rescue
      return false
    else
      f.rewind
      @html = f.readlines.join("\n")
      return true
    end
  end
  
  def header
    doc = Hpricot(self.html)
    return doc.search("head").to_s
  end
  
  def body
    doc = Hpricot(self.html)
    return doc.search("body").to_s
  end
end