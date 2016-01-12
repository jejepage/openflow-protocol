describe EchoRequest do
  let(:data) { [1, 2, 0, 8, 0, 0, 0, 1].pack('C*') }

  it 'should read binary' do
    msg = EchoRequest.read(data)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:echo_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
    expect(msg.data).to be_empty
  end
  it 'should be parsable' do
    msg = Parser.read(data)
    expect(msg.class).to eq(EchoRequest)
  end
  it 'should read binary with data' do
    msg = EchoRequest.read [1, 2, 0, 10, 0, 0, 0, 1, 10, 20].pack('C*')
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:echo_request)
    expect(msg.len).to eq(10)
    expect(msg.xid).to eq(1)
    expect(msg.data.length).to eq(2)
  end
  it 'should initialize with default values' do
    msg = EchoRequest.new
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:echo_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(0)
    expect(msg.data).to be_empty
  end
  it 'should initialize with some values' do
    msg = EchoRequest.new(xid: 1)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:echo_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
    expect(msg.data).to be_empty
  end
  it 'should initialize with data' do
    msg = EchoRequest.new(data: [10, 20].pack('C*'))
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:echo_request)
    expect(msg.len).to eq(10)
    expect(msg.xid).to eq(0)
    expect(msg.data.length).to eq(2)
  end
  it 'should convert to EchoReply' do
    msg = EchoRequest.new(xid: 1, data: [10, 20].pack('C*'))
    msg_reply = msg.to_reply
    expect(msg_reply.version).to eq(Message::OFP_VERSION)
    expect(msg_reply.type).to eq(:echo_reply)
    expect(msg.len).to eq(msg_reply.len)
    expect(msg.xid).to eq(msg_reply.xid)
    expect(msg.data).to eq(msg_reply.data)
  end
end
