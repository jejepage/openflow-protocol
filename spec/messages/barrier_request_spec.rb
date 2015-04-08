require 'spec_helper'

describe OFBarrierRequest do
  it 'should read binary' do
    msg = OFBarrierRequest.read [1, 18, 0, 8, 0, 0, 0, 1].pack('C*')
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:barrier_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end
  it 'should initialize with default values' do
    msg = OFBarrierRequest.new
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:barrier_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(0)
  end
  it 'should initialize with some values' do
    msg = OFBarrierRequest.new(xid: 1)
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:barrier_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end
end