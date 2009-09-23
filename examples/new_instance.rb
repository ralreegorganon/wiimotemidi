require 'wiimotemidi'

midi_thread = Thread.new do
  input = WiimoteMIDI::WiimoteInput.new("SB", "PortA", "Bus 1") 
  while true
    input.process_events do |event|
      puts event.inspect
    end
  end
end

gets # Stop on enter
