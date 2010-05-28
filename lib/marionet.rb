class Marionet
  require 'yaml'
  require 'slot'
  require 'logger'
  
  attr_accessor :slots
  
  #SET OF SLOT OBJECTS
  
  def initialize
    @log = Logger.new('log/log.txt')
    @PORTLETS ||= YAML.load_file('config/portlets.yml')
    @slots = []   
    
    @log.debug "initializing Marionet..."
    if not @PORTLETS.nil? then
      #LOAD ALL CONFIGURED PORTLETS
      @PORTLETS.each do |p|
        url = @PORTLETS[p[0]]['url']
        name = @PORTLETS[p[0]]['name']
        if slot = Slot.new(url,name) then
          @slots.push(slot)
          @log.debug "New Slot added."
        else
          puts "ERROR CREATING SLOT #{url}"
          @log.debug "Errore creating slot."
        end
      end
    else
      @log.debug "No Potlets configured."
    end
  end
  
  def render
    output = "<html><head></head><body>"
    self.slots.each do |slot|
      output = output + slot.render
    end
    output = output + "</body>"
    return output
  end
end