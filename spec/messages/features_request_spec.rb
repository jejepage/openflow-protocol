describe OpenFlow::Protocol::FeaturesRequest do
  let(:data) { [1, 5, 0, 8, 0, 0, 0, 1].pack('C*') }

  it 'should read binary' do
    msg = OpenFlow::Protocol::FeaturesRequest.read(data)
    expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
    expect(msg.type).to eq(:features_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end
  it 'should be parsable' do
    msg = OpenFlow::Protocol::Parser.read(data)
    expect(msg.class).to eq(OpenFlow::Protocol::FeaturesRequest)
  end
  it 'should initialize with default values' do
    msg = OpenFlow::Protocol::FeaturesRequest.new
    expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
    expect(msg.type).to eq(:features_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(0)
  end
  it 'should initialize with some values' do
    msg = OpenFlow::Protocol::FeaturesRequest.new(xid: 1)
    expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
    expect(msg.type).to eq(:features_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end
end
