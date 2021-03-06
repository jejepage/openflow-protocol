describe EchoReply do
  let(:data) { [1, 3, 0, 8, 0, 0, 0, 1].pack('C*') }

  it 'should read binary' do
    msg = EchoReply.read(data)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:echo_reply)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
    expect(msg.data).to be_empty
  end
  it 'should be parsable' do
    msg = Parser.read(data)
    expect(msg.class).to eq(EchoReply)
  end
  it 'should read binary with data' do
    msg = EchoReply.read [1, 3, 0, 10, 0, 0, 0, 1, 10, 20].pack('C*')
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:echo_reply)
    expect(msg.len).to eq(10)
    expect(msg.xid).to eq(1)
    expect(msg.data.length).to eq(2)
  end
  it 'should initialize with default values' do
    msg = EchoReply.new
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:echo_reply)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(0)
    expect(msg.data).to be_empty
  end
  it 'should initialize with some values' do
    msg = EchoReply.new(xid: 1)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:echo_reply)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
    expect(msg.data).to be_empty
  end
  it 'should initialize with data' do
    msg = EchoReply.new(data: [10, 20].pack('C*'))
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:echo_reply)
    expect(msg.len).to eq(10)
    expect(msg.xid).to eq(0)
    expect(msg.data.length).to eq(2)
  end
end
