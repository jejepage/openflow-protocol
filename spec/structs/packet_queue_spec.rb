describe OpenFlow::Protocol::PacketQueue do
  it 'should read binary' do
    queue = OpenFlow::Protocol::PacketQueue.read [
      0, 0, 0, 1, # queue_id
      0, 24,      # len
      0, 0,       # padding
      # queue_properties
      #   queue_property_min_rate
      0, 1, 0, 16, 0, 0, 0, 0, # header
      0, 100,                  # rate
      0, 0, 0, 0, 0, 0         # padding
    ].pack('C*')
    expect(queue.queue_id).to eq(1)
    expect(queue.len).to eq(24)
    expect(queue.properties.length).to eq(1)
    expect(queue.properties.first.type).to eq(:min_rate)
    expect(queue.properties.first.rate).to eq(100)
  end
  it 'should initialize with default values' do
    queue = OpenFlow::Protocol::PacketQueue.new
    expect(queue.queue_id).to eq(0)
    expect(queue.len).to eq(8)
  end
  it 'should initialize with some values' do
    queue = OpenFlow::Protocol::PacketQueue.new(
      queue_id: 1,
      properties: [OpenFlow::Protocol::QueuePropertyMinRate.new(rate: 100)]
    )
    expect(queue.queue_id).to eq(1)
    expect(queue.len).to eq(24)
    expect(queue.properties.length).to eq(1)
    expect(queue.properties.first.type).to eq(:min_rate)
    expect(queue.properties.first.rate).to eq(100)
  end
end
