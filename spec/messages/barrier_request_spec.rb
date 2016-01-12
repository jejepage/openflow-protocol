describe BarrierRequest do
  let(:data) { [1, 18, 0, 8, 0, 0, 0, 1].pack('C*') }

  it 'should read binary' do
    msg = BarrierRequest.read(data)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:barrier_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end
  it 'should be parsable' do
    msg = Parser.read(data)
    expect(msg.class).to eq(BarrierRequest)
  end
  it 'should initialize with default values' do
    msg = BarrierRequest.new
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:barrier_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(0)
  end
  it 'should initialize with some values' do
    msg = BarrierRequest.new(xid: 1)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:barrier_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end
end
