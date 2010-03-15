class Marionet
  require 'yaml'
  require 'slot'
  require 'logger'
  
  @log = Logger.new('log/log.txt')
  
  @PORTLETS ||= YAML.load_file('config/portlets.yml')
  #SET OF SLOT OBJECTS
  @WIRES = []
  
  def self.init
    @log.debug "initializing Marionet..."
    if not @PORTLETS.nil? then
      #LOAD ALL CONFIGURED PORTLETS
      @PORTLETS.each do |p|
        url = @PORTLETS[p[0]]['url']
        if slot = Slot.new(url) then
          @WIRES.push(slot)
          @log.debug "New Slot added."
        else
          puts "ERROR CREATING SLOT #{url}"
          @log.debug "Errore creating slot."
        end
      end
      return @WIRES
    else
      @log.debug "No Potlets configured."
      return nil
    end
  end
end