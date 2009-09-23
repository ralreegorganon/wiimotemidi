require 'wiimotemidi'

midi_thread = Thread.new do
    WiimoteMIDI::WiimoteInput.register_for_events("SB", "PortA", "Bus 1") do |event|
      puts event.inspect
  end 
end

gets # Stop on enter
