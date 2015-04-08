require 'spec_helper'

describe OFGetConfigRequest do
  it 'should read binary' do
    msg = OFGetConfigRequest.read [1, 7, 0, 8, 0, 0, 0, 1].pack('C*')
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:get_config_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end
  it 'should initialize with default values' do
    msg = OFGetConfigRequest.new
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:get_config_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(0)
  end
  it 'should initialize with some values' do
    msg = OFGetConfigRequest.new(xid: 1)
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:get_config_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
  end
end
