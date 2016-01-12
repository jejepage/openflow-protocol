require 'spec_helper'

describe OFBarrierReply do
  let(:data) { [1, 19, 0, 8, 0, 0, 0, 1].pack('C*') }

  it 'should read binary' do
    msg = OFBarrierReply.read(data)
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:barrier_reply)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end
  it 'should be parsable' do
    msg = OFParser.read(data)
    expect(msg.class).to eq(OFBarrierReply)
  end
  it 'should initialize with default values' do
    msg = OFBarrierReply.new
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:barrier_reply)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(0)
  end
  it 'should initialize with some values' do
    msg = OFBarrierReply.new(xid: 1)
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:barrier_reply)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end
end
