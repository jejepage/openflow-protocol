describe ActionSetIpSource do
  it 'should read binary' do
    action = ActionSetIpSource.read [
      0, 6, 0, 8, # header
      10, 0, 0, 1 # ip_address
    ].pack('C*')
    expect(action.type).to eq(:set_ip_source)
    expect(action.len).to eq(8)
    expect(action.ip_address).to eq('10.0.0.1')
  end
  it 'should initialize with default values' do
    action = ActionSetIpSource.new
    expect(action.type).to eq(:set_ip_source)
    expect(action.len).to eq(8)
    expect(action.ip_address).to eq('0.0.0.0')
  end
  it 'should initialize with some values' do
    action = ActionSetIpSource.new(ip_address: '10.0.0.1')
    expect(action.type).to eq(:set_ip_source)
    expect(action.len).to eq(8)
    expect(action.ip_address).to eq('10.0.0.1')
  end
end
