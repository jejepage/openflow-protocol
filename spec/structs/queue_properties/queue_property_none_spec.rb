describe QueuePropertyNone do
  it 'should read binary' do
    prop = QueuePropertyNone.read [0, 0, 0, 8, 0, 0, 0, 0].pack('C*')
    expect(prop.type).to eq(:none)
    expect(prop.len).to eq(8)
  end
  it 'should initialize with default values' do
    prop = QueuePropertyNone.new
    expect(prop.type).to eq(:none)
    expect(prop.len).to eq(8)
  end
end
