describe OpenFlow::Protocol::ActionSetVlanId do
  it 'should read binary' do
    action = OpenFlow::Protocol::ActionSetVlanId.read [
      0, 1, 0, 8, # header
      0, 1,       # vlan_id
      0, 0        # padding
    ].pack('C*')
    expect(action.type).to eq(:set_vlan_id)
    expect(action.len).to eq(8)
    expect(action.vlan_id).to eq(1)
  end
  it 'should initialize with default values' do
    action = OpenFlow::Protocol::ActionSetVlanId.new
    expect(action.type).to eq(:set_vlan_id)
    expect(action.len).to eq(8)
    expect(action.vlan_id).to eq(0)
  end
  it 'should initialize with some values' do
    action = OpenFlow::Protocol::ActionSetVlanId.new(vlan_id: 1)
    expect(action.type).to eq(:set_vlan_id)
    expect(action.len).to eq(8)
    expect(action.vlan_id).to eq(1)
  end
end
