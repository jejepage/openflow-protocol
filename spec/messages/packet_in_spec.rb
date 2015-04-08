require 'spec_helper'

describe OFPacketIn do
  it 'should read binary' do
    msg = OFPacketIn.read [
      1, 10, 0, 20, 0, 0, 0, 1, # header
      0, 0, 0, 1,               # buffer_id
      0, 2,                     # total_length
      0, 1,                     # in_port
      0,                        # reason
      0,                        # padding
      1, 2                      # data
    ].pack('C*')
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:packet_in)
    expect(msg.len).to eq(20)
    expect(msg.xid).to eq(1)
    expect(msg.buffer_id).to eq(1)
    expect(msg.total_length).to eq(2)
    expect(msg.in_port).to eq(1)
    expect(msg.reason).to eq(:no_match)
    expect(msg.data.length).to eq(2)
  end
  it 'should initialize with default values' do
    msg = OFPacketIn.new
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:packet_in)
    expect(msg.len).to eq(18)
    expect(msg.xid).to eq(0)
    expect(msg.buffer_id).to eq(:none)
    expect(msg.total_length).to eq(0)
    expect(msg.in_port).to eq(:none)
    expect(msg.reason).to eq(:no_match)
    expect(msg.data).to be_empty
  end
  it 'should initialize with some values' do
    msg = OFPacketIn.new(
      xid: 1,
      buffer_id: 1,
      in_port: 1,
      reason: :no_match,
      data: [1, 2].pack('C*')
    )
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:packet_in)
    expect(msg.len).to eq(20)
    expect(msg.xid).to eq(1)
    expect(msg.buffer_id).to eq(1)
    expect(msg.total_length).to eq(2)
    expect(msg.in_port).to eq(1)
    expect(msg.reason).to eq(:no_match)
    expect(msg.data.length).to eq(2)
  end
end
