describe ActionOutput do
  it 'should read binary' do
    action = ActionOutput.read [
      0, 0, 0, 8, # header
      0, 1,       # port
      0xff, 0xff  # max_length
    ].pack('C*')
    expect(action.type).to eq(:output)
    expect(action.len).to eq(8)
    expect(action.port).to eq(1)
    expect(action.max_length).to eq(0xffff)
  end
  it 'should initialize with default values' do
    action = ActionOutput.new
    expect(action.type).to eq(:output)
    expect(action.len).to eq(8)
    expect(action.port).to eq(:none)
    expect(action.max_length).to eq(0xffff)
  end
  it 'should initialize with some values' do
    action = ActionOutput.new(port: 1)
    expect(action.type).to eq(:output)
    expect(action.len).to eq(8)
    expect(action.port).to eq(1)
    expect(action.max_length).to eq(0xffff)
  end
end
