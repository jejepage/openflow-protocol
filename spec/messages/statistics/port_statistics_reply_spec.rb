describe PortStatisticsReply do
  it 'should read binary' do
    stats = PortStatisticsReply.read [
      0, 1,                    # port_number
      0, 0, 0, 0, 0, 0,        # padding
      0, 0, 0, 0, 0, 0, 0, 10, # receive_packets
      0, 0, 0, 0, 0, 0, 0, 10, # transmit_packets
      0, 0, 0, 0, 0, 0, 0, 80, # receive_bytes
      0, 0, 0, 0, 0, 0, 0, 80, # transmit_bytes
      0, 0, 0, 0, 0, 0, 0, 5,  # receive_dropped
      0, 0, 0, 0, 0, 0, 0, 5,  # transmit_dropped
      0, 0, 0, 0, 0, 0, 0, 2,  # receive_errors
      0, 0, 0, 0, 0, 0, 0, 2,  # transmit_errors
      0, 0, 0, 0, 0, 0, 0, 1,  # receive_frame_errors
      0, 0, 0, 0, 0, 0, 0, 0,  # receive_overrun_errors
      0, 0, 0, 0, 0, 0, 0, 1,  # receive_crc_errors
      0, 0, 0, 0, 0, 0, 0, 3   # collisions
    ].pack('C*')
    expect(stats.port_number).to eq(1)
    expect(stats.receive_packets).to eq(10)
    expect(stats.transmit_packets).to eq(10)
    expect(stats.receive_bytes).to eq(80)
    expect(stats.transmit_bytes).to eq(80)
    expect(stats.receive_dropped).to eq(5)
    expect(stats.transmit_dropped).to eq(5)
    expect(stats.receive_errors).to eq(2)
    expect(stats.transmit_errors).to eq(2)
    expect(stats.receive_frame_errors).to eq(1)
    expect(stats.receive_overrun_errors).to eq(0)
    expect(stats.receive_crc_errors).to eq(1)
    expect(stats.collisions).to eq(3)
  end
  it 'should initialize with default values' do
    stats = PortStatisticsReply.new
    expect(stats.port_number).to eq(0)
    expect(stats.receive_packets).to eq(0)
    expect(stats.transmit_packets).to eq(0)
    expect(stats.receive_bytes).to eq(0)
    expect(stats.transmit_bytes).to eq(0)
    expect(stats.receive_dropped).to eq(0)
    expect(stats.transmit_dropped).to eq(0)
    expect(stats.receive_errors).to eq(0)
    expect(stats.transmit_errors).to eq(0)
    expect(stats.receive_frame_errors).to eq(0)
    expect(stats.receive_overrun_errors).to eq(0)
    expect(stats.receive_crc_errors).to eq(0)
    expect(stats.collisions).to eq(0)
  end
  it 'should initialize with some values' do
    stats = PortStatisticsReply.new(
      port_number: 1,
      receive_packets: 10,
      transmit_packets: 10,
      receive_bytes: 80,
      transmit_bytes: 80,
      receive_dropped: 5,
      transmit_dropped: 5,
      receive_errors: 2,
      transmit_errors: 2,
      receive_frame_errors: 1,
      receive_overrun_errors: 0,
      receive_crc_errors: 1,
      collisions: 3
    )
    expect(stats.port_number).to eq(1)
    expect(stats.receive_packets).to eq(10)
    expect(stats.transmit_packets).to eq(10)
    expect(stats.receive_bytes).to eq(80)
    expect(stats.transmit_bytes).to eq(80)
    expect(stats.receive_dropped).to eq(5)
    expect(stats.transmit_dropped).to eq(5)
    expect(stats.receive_errors).to eq(2)
    expect(stats.transmit_errors).to eq(2)
    expect(stats.receive_frame_errors).to eq(1)
    expect(stats.receive_overrun_errors).to eq(0)
    expect(stats.receive_crc_errors).to eq(1)
    expect(stats.collisions).to eq(3)
  end
end
