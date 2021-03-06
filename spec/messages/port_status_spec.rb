describe PortStatus do
  let(:data) {
    [
      1, 12, 0, 64, 0, 0, 0, 1, # header
      1,                        # reason
      0, 0, 0, 0, 0, 0, 0,      # padding
      # port
      0, 1,               # port_number
      0, 0, 0, 0, 0, 1,   # hardware_address
      112, 111, 114, 116, # name
      45, 49, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 1,         # config
      0, 0, 0, 1,         # state
      0, 0, 0x0f, 0xff,   # current_features
      0, 0, 0x0f, 0xff,   # advertised_features
      0, 0, 0x0f, 0xff,   # supported_features
      0, 0, 0x0f, 0xff    # peer_features
    ].pack('C*')
  }

  it 'should read binary' do
    msg = PortStatus.read(data)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:port_status)
    expect(msg.len).to eq(64)
    expect(msg.xid).to eq(1)
    expect(msg.reason).to eq(:delete)
    expect(msg.desc.port_number).to eq(1)
  end
  it 'should be parsable' do
    msg = Parser.read(data)
    expect(msg.class).to eq(PortStatus)
  end
  it 'should initialize with default values' do
    msg = PortStatus.new
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:port_status)
    expect(msg.len).to eq(64)
    expect(msg.xid).to eq(0)
    expect(msg.reason).to eq(:add)
    expect(msg.desc.port_number).to eq(0)
  end
  it 'should initialize with some values' do
    msg = PortStatus.new(
      xid: 1,
      reason: :delete,
      desc: PhysicalPort.new(port_number: 1)
    )
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:port_status)
    expect(msg.len).to eq(64)
    expect(msg.xid).to eq(1)
    expect(msg.reason).to eq(:delete)
    expect(msg.desc.port_number).to eq(1)
  end
end
