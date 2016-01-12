describe OpenFlow::Protocol::Actions do
  it 'should read binary' do
    actions = OpenFlow::Protocol::Actions.read [
      # output
      0, 0, 0, 8, # header
      0, 1,       # port
      0xff, 0xff, # max_length
      # enqueue
      0, 11, 0, 16,     # header
      0, 1,             # port
      0, 0, 0, 0, 0, 0, # padding
      0, 0, 0, 1        # queue_id
    ].pack('C*'), length: 24
    expect(actions.length).to eq(2)
    expect(actions.first.type).to eq(:output)
    expect(actions.last.type).to eq(:enqueue)
  end
  it 'should initialize with default values' do
    actions = OpenFlow::Protocol::Actions.new
    expect(actions).to be_empty
  end
  it 'should initialize with some values' do
    actions = OpenFlow::Protocol::Actions.new([
      OpenFlow::Protocol::ActionOutput.new(port: 1, max_length: 0xffff),
      OpenFlow::Protocol::ActionEnqueue.new(port: 1, queue_id: 1)
    ])
    expect(actions.length).to eq(2)
    expect(actions.first.type).to eq(:output)
    expect(actions.last.type).to eq(:enqueue)
  end
end
