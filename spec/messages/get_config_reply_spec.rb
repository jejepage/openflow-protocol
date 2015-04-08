require 'spec_helper'

describe OFGetConfigReply do
  it 'should read binary' do
    msg = OFGetConfigReply.read [
      1, 8, 0, 12, 0, 0, 0, 1, # header
      0, 0,                    # flags
      0, 0xff                  # miss_send_length
    ].pack('C*')
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:get_config_reply)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(1)
    expect(msg.flags).to eq(:fragments_normal)
    expect(msg.miss_send_length).to eq(0xff)
  end
  it 'should initialize with default values' do
    msg = OFGetConfigReply.new
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:get_config_reply)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(0)
    expect(msg.flags).to eq(:fragments_normal)
    expect(msg.miss_send_length).to eq(0)
  end
  it 'should initialize with some values' do
    msg = OFGetConfigReply.new(
      xid: 1,
      flags: :fragments_normal,
      miss_send_length: 0xff
    )
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:get_config_reply)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(1)
    expect(msg.flags).to eq(:fragments_normal)
    expect(msg.miss_send_length).to eq(0xff)
  end
end
