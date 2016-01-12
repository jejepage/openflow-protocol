describe OpenFlow::Protocol::ActionVendor do
  it 'should read binary' do
    action = OpenFlow::Protocol::ActionVendor.read [
      0xff, 0xff, 0, 8, # header
      0, 0, 0, 1        # vendor
    ].pack('C*')
    expect(action.type).to eq(:vendor)
    expect(action.len).to eq(8)
    expect(action.vendor).to eq(1)
  end
  it 'should initialize with default values' do
    action = OpenFlow::Protocol::ActionVendor.new
    expect(action.type).to eq(:vendor)
    expect(action.len).to eq(8)
    expect(action.vendor).to eq(0)
  end
  it 'should initialize with some values' do
    action = OpenFlow::Protocol::ActionVendor.new(vendor: 1)
    expect(action.type).to eq(:vendor)
    expect(action.len).to eq(8)
    expect(action.vendor).to eq(1)
  end
end
