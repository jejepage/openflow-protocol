require 'spec_helper'

describe OFPacketOut do
  let(:data) {
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

  it 'should read binary' do
    msg = OFPacketOut.read(data)
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:packet_out)
    expect(msg.len).to eq(26)
    expect(msg.xid).to eq(1)
    expect(msg.buffer_id).to eq(:none)
    expect(msg.in_port).to eq(1)
    expect(msg.actions.length).to eq(1)
    expect(msg.actions.first.type).to eq(:output)
    expect(msg.data.length).to eq(2)
  end
  it 'should be parsable' do
    msg = OFParser.read(data)
    expect(msg.class).to eq(OFPacketOut)
  end
  it 'should initialize with default values' do
    msg = OFPacketOut.new
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:packet_out)
    expect(msg.len).to eq(16)
    expect(msg.xid).to eq(0)
    expect(msg.buffer_id).to eq(:none)
    expect(msg.in_port).to eq(:none)
    expect(msg.actions).to be_empty
    expect(msg.data).to be_empty
  end
  it 'should initialize with some values' do
    msg = OFPacketOut.new(
      xid: 1,
      in_port: 1,
      actions: [OFActionOutput.new(port: 1)],
      data: [1, 2].pack('C*')
    )
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
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
