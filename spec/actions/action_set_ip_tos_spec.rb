describe ActionSetIpTos do
  it 'should read binary' do
    action = ActionSetIpTos.read [
      0, 8, 0, 8, # header
      10,         # tos
      0, 0, 0     # padding
    ].pack('C*')
    expect(action.type).to eq(:set_ip_tos)
    expect(action.len).to eq(8)
    expect(action.tos).to eq(10)
  end
  it 'should initialize with default values' do
    action = ActionSetIpTos.new
    expect(action.type).to eq(:set_ip_tos)
    expect(action.len).to eq(8)
    expect(action.tos).to eq(0)
  end
  it 'should initialize with some values' do
    action = ActionSetIpTos.new(tos: 10)
    expect(action.type).to eq(:set_ip_tos)
    expect(action.len).to eq(8)
    expect(action.tos).to eq(10)
  end
end
