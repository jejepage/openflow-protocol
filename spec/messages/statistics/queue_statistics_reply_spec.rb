describe QueueStatisticsReply do
  it 'should read binary' do
    stats = QueueStatisticsReply.read [
      0, 1,                    # port_number
      0, 0,                    # padding
      0, 0, 0, 1,              # queue_id
      0, 0, 0, 0, 0, 0, 0, 80, # transmit_bytes
      0, 0, 0, 0, 0, 0, 0, 10, # transmit_packets
      0, 0, 0, 0, 0, 0, 0, 2   # transmit_errors
    ].pack('C*')
    expect(stats.port_number).to eq(1)
    expect(stats.queue_id).to eq(1)
    expect(stats.transmit_bytes).to eq(80)
    expect(stats.transmit_packets).to eq(10)
    expect(stats.transmit_errors).to eq(2)
  end
  it 'should initialize with default values' do
    stats = QueueStatisticsReply.new
    expect(stats.port_number).to eq(0)
    # expect(stats.queue_id).to eq(:all)
    # TODO: QUEUE_IDS somewhere!
    expect(stats.transmit_bytes).to eq(0)
    expect(stats.transmit_packets).to eq(0)
    expect(stats.transmit_errors).to eq(0)
  end
  it 'should initialize with some values' do
    stats = QueueStatisticsReply.new(
      port_number: 1,
      queue_id: 1,
      transmit_bytes: 80,
      transmit_packets: 10,
      transmit_errors: 2
    )
    expect(stats.port_number).to eq(1)
    expect(stats.queue_id).to eq(1)
    expect(stats.transmit_bytes).to eq(80)
    expect(stats.transmit_packets).to eq(10)
    expect(stats.transmit_errors).to eq(2)
  end
end
