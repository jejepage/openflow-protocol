require 'spec_helper'

describe OFQueueGetConfigReply do
  let(:data) {
    [
      1, 21, 0, 48, 0, 0, 0, 1, # header
      0, 1,                     # port
      0, 0, 0, 0, 0, 0,         # padding
      # queue 1
      0, 0, 0, 1, # queue_id
      0, 24,      # len
      0, 0,       # padding
      #   queue_properties
      #     queue_property_min_rate
      0, 1, 0, 16, 0, 0, 0, 0, # header
      0, 100,                  # rate
      0, 0, 0, 0, 0, 0,        # padding
      # queue 2
      0, 0, 0, 2, # queue_id
      0, 8,       # len
      0, 0        # padding
    ].pack('C*')
  }

  it 'should read binary' do
    msg = OFQueueGetConfigReply.read(data)
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:queue_get_config_reply)
    expect(msg.len).to eq(48)
    expect(msg.xid).to eq(1)
    expect(msg.port).to eq(1)
    expect(msg.queues.length).to eq(2)
    expect(msg.queues.first.queue_id).to eq(1)
    expect(msg.queues.first.properties.length).to eq(1)
    expect(msg.queues.last.queue_id).to eq(2)
  end
  it 'should be parsable' do
    msg = OFParser.read(data)
    expect(msg.class).to eq(OFQueueGetConfigReply)
  end
  it 'should initialize with default values' do
    msg = OFQueueGetConfigReply.new
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:queue_get_config_reply)
    expect(msg.len).to eq(16)
    expect(msg.xid).to eq(0)
    expect(msg.port).to eq(0)
    expect(msg.queues).to be_empty
  end
  it 'should initialize with some values' do
    msg = OFQueueGetConfigReply.new(
      xid: 1,
      port: 2,
      queues: [
        { queue_id: 1 },
        { queue_id: 2 },
      ]
    )
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:queue_get_config_reply)
    expect(msg.len).to eq(32)
    expect(msg.xid).to eq(1)
    expect(msg.port).to eq(2)
    expect(msg.queues.length).to eq(2)
    expect(msg.queues.first.queue_id).to eq(1)
    expect(msg.queues.last.queue_id).to eq(2)
  end
end
