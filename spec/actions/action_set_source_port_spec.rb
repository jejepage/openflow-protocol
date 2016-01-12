describe ActionSetSourcePort do
  it 'should read binary' do
    action = ActionSetSourcePort.read [
      0, 9, 0, 8, # header
      0, 1,       # port
      0, 0        # padding
    ].pack('C*')
    expect(action.type).to eq(:set_source_port)
    expect(action.len).to eq(8)
    expect(action.port).to eq(1)
  end
  it 'should initialize with default values' do
    action = ActionSetSourcePort.new
    expect(action.type).to eq(:set_source_port)
    expect(action.len).to eq(8)
    expect(action.port).to eq(0)
  end
  it 'should initialize with some values' do
    action = ActionSetSourcePort.new(port: 1)
    expect(action.type).to eq(:set_source_port)
    expect(action.len).to eq(8)
    expect(action.port).to eq(1)
  end
end
