describe Error do
  let(:hello_msg) {
    [1, 0, 0, 8, 0, 0, 0, 1].pack('C*')
  }
  let(:data) {
    [
      1, 1, 0, 20, 0, 0, 0, 1, # header
      0, 0,                    # type
      0, 0                     # code
    ].pack('C*') + hello_msg
  }

  it 'should read binary' do
    msg = Error.read(data)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:error)
    expect(msg.len).to eq(20)
    expect(msg.xid).to eq(1)
    expect(msg.error_type).to eq(:hello_failed)
    expect(msg.error_code).to eq(:incompatible)
    expect(msg.data).to eq(hello_msg)
    hello = msg.parsed_data
    expect(hello.type).to eq(:hello)
    expect(hello.xid).to eq(1)
  end
  it 'should be parsable' do
    msg = Parser.read(data)
    expect(msg.class).to eq(Error)
  end
  it 'should read another binary' do
    msg = Error.read [
      1, 1, 0, 12, 0, 0, 0, 1, # header
      0, 2,                    # type
      0, 4                     # code
    ].pack('C*')
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:error)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(1)
    expect(msg.error_type).to eq(:bad_action)
    expect(msg.error_code).to eq(:bad_out_port)
    expect(msg.data).to be_empty
  end
  it 'should initialize with default values' do
    msg = Error.new
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:error)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(0)
    expect(msg.error_type).to eq(:hello_failed)
    expect(msg.error_code).to eq(:incompatible)
    expect(msg.data).to be_empty
  end
  it 'should initialize with some values' do
    msg = Error.new(
      xid: 1,
      error_type: :port_mod_failed,
      error_code: :bad_port
    )
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:error)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(1)
    expect(msg.error_type).to eq(:port_mod_failed)
    expect(msg.error_code).to eq(:bad_port)
  end
end
