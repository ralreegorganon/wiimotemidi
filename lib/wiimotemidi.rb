require 'coremidi'

module WiimoteMIDI
  class WiimoteInput
    
    def initialize(client_name, port_name, source)
      raise "name must be a String!" unless client_name.class == String
      client = CoreMIDI::API.create_client(client_name) 
      port = CoreMIDI::API.create_input_port(client, port_name)
      CoreMIDI::API.connect_source_to_port(CoreMIDI::API.get_sources.index(source), port)
    end
    
    def process_events
      data = CoreMIDI::API.check_for_new_data
      if data && !data.empty?
        data.each do |packet|
          while (d = packet.data.slice!(0,3)).length > 0
            yield(CoreMIDI::Packet.parse(d))
          end
        end
      end
    end
  
    def self.register_for_events(client_name, port_name, source)
      wiimote = WiimoteInput.new(client_name, port_name, source)
      while true
        wiimote.process_events do |event|
          yield event
        end
        sleep 0.001
      end
    end
  end
end