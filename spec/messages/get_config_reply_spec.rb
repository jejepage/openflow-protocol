describe OpenFlow::Protocol::GetConfigReply do
  let(:data) {
    [
      1, 8, 0, 12, 0, 0, 0, 1, # header
      0, 0,                    # flags
      0, 0xff                  # miss_send_length
    ].pack('C*')
  }

  it 'should read binary' do
    msg = OpenFlow::Protocol::GetConfigReply.read(data)
    expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
    expect(msg.type).to eq(:get_config_reply)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(1)
    expect(msg.flags).to eq(:fragments_normal)
    expect(msg.miss_send_length).to eq(0xff)
  end
  it 'should be parsable' do
    msg = OpenFlow::Protocol::Parser.read(data)
    expect(msg.class).to eq(OpenFlow::Protocol::GetConfigReply)
  end
  it 'should initialize with default values' do
    msg = OpenFlow::Protocol::GetConfigReply.new
    expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
    expect(msg.type).to eq(:get_config_reply)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(0)
    expect(msg.flags).to eq(:fragments_normal)
    expect(msg.miss_send_length).to eq(0)
  end
  it 'should initialize with some values' do
    msg = OpenFlow::Protocol::GetConfigReply.new(
      xid: 1,
      flags: :fragments_normal,
      miss_send_length: 0xff
    )
    expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
    expect(msg.type).to eq(:get_config_reply)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(1)
    expect(msg.flags).to eq(:fragments_normal)
    expect(msg.miss_send_length).to eq(0xff)
  end
end
