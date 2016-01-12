require 'spec_helper'

describe OFEchoRequest do
  let(:data) { [1, 2, 0, 8, 0, 0, 0, 1].pack('C*') }

  it 'should read binary' do
    msg = OFEchoRequest.read(data)
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:echo_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
    expect(msg.data).to be_empty
  end
  it 'should be parsable' do
    msg = OFParser.read(data)
    expect(msg.class).to eq(OFEchoRequest)
  end
  it 'should read binary with data' do
    msg = OFEchoRequest.read [1, 2, 0, 10, 0, 0, 0, 1, 10, 20].pack('C*')
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:echo_request)
    expect(msg.len).to eq(10)
    expect(msg.xid).to eq(1)
    expect(msg.data.length).to eq(2)
  end
  it 'should initialize with default values' do
    msg = OFEchoRequest.new
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:echo_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(0)
    expect(msg.data).to be_empty
  end
  it 'should initialize with some values' do
    msg = OFEchoRequest.new(xid: 1)
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:echo_request)
    expect(msg.len).to eq(8)
    expect(msg.xid).to eq(1)
    expect(msg.data).to be_empty
  end
  it 'should initialize with data' do
    msg = OFEchoRequest.new(data: [10, 20].pack('C*'))
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:echo_request)
    expect(msg.len).to eq(10)
    expect(msg.xid).to eq(0)
    expect(msg.data.length).to eq(2)
  end
  it 'should convert to OFEchoReply' do
    msg = OFEchoRequest.new(xid: 1, data: [10, 20].pack('C*'))
    msg_reply = msg.to_reply
    expect(msg_reply.version).to eq(OFMessage::OFP_VERSION)
    expect(msg_reply.type).to eq(:echo_reply)
    expect(msg.len).to eq(msg_reply.len)
    expect(msg.xid).to eq(msg_reply.xid)
    expect(msg.data).to eq(msg_reply.data)
  end
end
