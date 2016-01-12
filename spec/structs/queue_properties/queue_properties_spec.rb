describe QueueProperties do
  it 'should read binary' do
    props = QueueProperties.read [
      # none
      0, 0, 0, 8, 0, 0, 0, 0,
      # min_rate
      0, 1, 0, 8, 0, 0, 0, 0, # header
      0, 100,                 # rate
      0, 0, 0, 0, 0, 0        # padding
    ].pack('C*'), length: 24
    expect(props.length).to eq(2)
    expect(props.first.type).to eq(:none)
    expect(props.last.type).to eq(:min_rate)
  end
  it 'should initialize with default values' do
    props = QueueProperties.new
    expect(props).to be_empty
  end
  it 'should initialize with some values' do
    props = QueueProperties.new([
      QueuePropertyMinRate.new(rate: 100)
    ])
    expect(props.length).to eq(1)
    expect(props.first.type).to eq(:min_rate)
    expect(props.first.rate).to eq(100)
  end
end
