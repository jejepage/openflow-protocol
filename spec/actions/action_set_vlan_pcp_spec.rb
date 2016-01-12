describe ActionSetVlanPcp do
  it 'should read binary' do
    action = ActionSetVlanPcp.read [
      0, 2, 0, 8, # header
      1,          # vlan_pcp
      0, 0, 0     # padding
    ].pack('C*')
    expect(action.type).to eq(:set_vlan_pcp)
    expect(action.len).to eq(8)
    expect(action.vlan_pcp).to eq(1)
  end
  it 'should initialize with default values' do
    action = ActionSetVlanPcp.new
    expect(action.type).to eq(:set_vlan_pcp)
    expect(action.len).to eq(8)
    expect(action.vlan_pcp).to eq(0)
  end
  it 'should initialize with some values' do
    action = ActionSetVlanPcp.new(vlan_pcp: 1)
    expect(action.type).to eq(:set_vlan_pcp)
    expect(action.len).to eq(8)
    expect(action.vlan_pcp).to eq(1)
  end
end
