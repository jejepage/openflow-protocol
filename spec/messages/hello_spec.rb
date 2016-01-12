describe OpenFlow::Protocol::Hello do
  let(:data) { [1, 0, 0, 8, 0, 0, 0, 1].pack('C*') }

  it 'should read binary' do
    msg = OpenFlow::Protocol::Hello.read(data)
    expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
    expect(msg.type).to eq(:hello)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end
  it 'should be parsable' do
    msg = OpenFlow::Protocol::Parser.read(data)
    expect(msg.class).to eq(OpenFlow::Protocol::Hello)
  end
  it 'should initialize with default values' do
    msg = OpenFlow::Protocol::Hello.new
    expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
    expect(msg.type).to eq(:hello)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(0)
  end
  it 'should initialize with some values' do
    msg = OpenFlow::Protocol::Hello.new(xid: 1)
    expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
    expect(msg.type).to eq(:hello)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end
end
