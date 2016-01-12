describe Vendor do
  let(:data) {
    [
      1, 4, 0, 12, 0, 0, 0, 1, # header
      0, 0, 0, 1               # vendor
    ].pack('C*')
  }

  it 'should read binary' do
    msg = Vendor.read(data)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:vendor)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(1)
    expect(msg.vendor).to eq(1)
    expect(msg.data).to be_empty
  end
  it 'should be parsable' do
    msg = Parser.read(data)
    expect(msg.class).to eq(Vendor)
  end
  it 'should read binary with data' do
    msg = Vendor.read [
      1, 4, 0, 14, 0, 0, 0, 1, # header
      0, 0, 0, 1,              # vendor
      10, 20                   # data
    ].pack('C*')
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:vendor)
    expect(msg.len).to eq(14)
    expect(msg.xid).to eq(1)
    expect(msg.vendor).to eq(1)
    expect(msg.data.length).to eq(2)
  end
  it 'should initialize with default values' do
    msg = Vendor.new
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:vendor)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(0)
    expect(msg.vendor).to eq(0)
    expect(msg.data).to be_empty
  end
  it 'should initialize with some values' do
    msg = Vendor.new(xid: 1, vendor: 1)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:vendor)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(1)
    expect(msg.vendor).to eq(1)
    expect(msg.data).to be_empty
  end
  it 'should initialize with data' do
    msg = Vendor.new(vendor: 1, data: [10, 20].pack('C*'))
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:vendor)
    expect(msg.len).to eq(14)
    expect(msg.xid).to eq(0)
    expect(msg.vendor).to eq(1)
    expect(msg.data.length).to eq(2)
  end
end
