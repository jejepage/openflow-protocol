describe OpenFlow::Protocol::ActionStripVlan do
  it 'should read binary' do
    action = OpenFlow::Protocol::ActionStripVlan.read [
      0, 3, 0, 8, # header
      0, 0, 0, 0  # padding
    ].pack('C*')
    expect(action.type).to eq(:strip_vlan)
    expect(action.len).to eq(8)
  end
  it 'should initialize with default values' do
    action = OpenFlow::Protocol::ActionStripVlan.new
    expect(action.type).to eq(:strip_vlan)
    expect(action.len).to eq(8)
  end
end
