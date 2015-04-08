require 'spec_helper'

describe OFFeaturesRequest do
  it 'should read binary' do
    msg = OFFeaturesRequest.read [1, 5, 0, 8, 0, 0, 0, 1].pack('C*')
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:features_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end
  it 'should initialize with default values' do
    msg = OFFeaturesRequest.new
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:features_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(0)
  end
  it 'should initialize with some values' do
    msg = OFFeaturesRequest.new(xid: 1)
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:features_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end
end
