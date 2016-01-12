describe QueueGetConfigRequest do
  let(:data) {
    [
      1, 20, 0, 12, 0, 0, 0, 1, # header
      0, 1,                     # port
      0, 0                      # padding
    ].pack('C*')
  }

  it 'should read binary' do
    msg = QueueGetConfigRequest.read(data)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:queue_get_config_request)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(1)
    expect(msg.port).to eq(1)
  end
  it 'should be parsable' do
    msg = Parser.read(data)
    expect(msg.class).to eq(QueueGetConfigRequest)
  end
  it 'should initialize with default values' do
    msg = QueueGetConfigRequest.new
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:queue_get_config_request)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(0)
    expect(msg.port).to eq(0)
  end
  it 'should initialize with some values' do
    msg = QueueGetConfigRequest.new(xid: 1, port: 2)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:queue_get_config_request)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(1)
    expect(msg.port).to eq(2)
  end
end
