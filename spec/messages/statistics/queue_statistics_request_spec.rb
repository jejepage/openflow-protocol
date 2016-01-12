describe OpenFlow::Protocol::QueueStatisticsRequest do
  it 'should read binary' do
    stats = OpenFlow::Protocol::QueueStatisticsRequest.read [
      0, 1,      # port_number
      0, 0,      # padding
      0, 0, 0, 1 # queue_id
    ].pack('C*')
    expect(stats.port_number).to eq(1)
    expect(stats.queue_id).to eq(1)
  end
  it 'should initialize with default values' do
    stats = OpenFlow::Protocol::QueueStatisticsRequest.new
    expect(stats.port_number).to eq(:all)
    expect(stats.queue_id).to eq(:all)
  end
  it 'should initialize with some values' do
    stats = OpenFlow::Protocol::QueueStatisticsRequest.new(
      port_number: 1,
      queue_id: 1
    )
    expect(stats.port_number).to eq(1)
    expect(stats.queue_id).to eq(1)
  end
end
