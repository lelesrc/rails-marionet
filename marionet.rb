class Marionet
  require 'yaml'
  require 'slot'
  @PORTLETS ||= YAML.load_file('config/portlets.yml')
  #SET OF SLOT OBJECTS
  @WIRES = []
  
  def self.init
    if not @PORTLETS.nil? then
      #LOAD ALL CONFIGURED PORTLETS
      @PORTLETS.each do |p|
        url = @PORTLETS[p[0]]['url']
        if slot = Slot.new(url) then
          @WIRES.push(slot)
        else
          puts "ERROR CREATING SLOT #{url}"
        end
      end
      return @WIRES
    else
      return nil
    end
  end
end