describe Parser do
  let(:hello_msg) { [1, 0, 0, 8, 0, 0, 0, 1].pack('C*') }
  let(:packet_out_msg) {
    [
      1, 13, 0, 26, 0, 0, 0, 1, # header
      0xff, 0xff, 0xff, 0xff,   # buffer_id
      0, 1,                     # in_port
      0, 8,                     # actions_length
      # actions
      #   output
      0, 0, 0, 8, # header
      0, 1,       # port
      0xff, 0xff, # max_length
      # data
      1, 2
    ].pack('C*')
  }

  it 'should read binary Hello Message' do
    msg = Parser.read(hello_msg)
    expect(msg.class).to be(Hello)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:hello)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end

  it 'should read binary PacketOut Message' do
    msg = Parser.read(packet_out_msg)
    expect(msg.class).to be(PacketOut)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:packet_out)
    expect(msg.len).to eq(26)
    expect(msg.xid).to eq(1)
    expect(msg.buffer_id).to eq(:none)
    expect(msg.in_port).to eq(1)
    expect(msg.actions.length).to eq(1)
    expect(msg.actions.first.type).to eq(:output)
    expect(msg.data.length).to eq(2)
  end
end
