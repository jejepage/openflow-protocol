describe SetConfig do
  let(:data) {
    [
      1, 9, 0, 12, 0, 0, 0, 1, # header
      0, 0,                    # flags
      0, 0xff                  # miss_send_length
    ].pack('C*')
  }

  it 'should read binary' do
    msg = SetConfig.read(data)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:set_config)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(1)
    expect(msg.flags).to eq(:fragments_normal)
    expect(msg.miss_send_length).to eq(0xff)
  end
  it 'should be parsable' do
    msg = Parser.read(data)
    expect(msg.class).to eq(SetConfig)
  end
  it 'should initialize with default values' do
    msg = SetConfig.new
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:set_config)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(0)
    expect(msg.flags).to eq(:fragments_normal)
    expect(msg.miss_send_length).to eq(0)
  end
  it 'should initialize with some values' do
    msg = SetConfig.new(
      xid: 1,
      flags: :fragments_normal,
      miss_send_length: 0xff
    )
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:set_config)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(1)
    expect(msg.flags).to eq(:fragments_normal)
    expect(msg.miss_send_length).to eq(0xff)
  end
end
