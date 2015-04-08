require 'spec_helper'

describe OFActionEnqueue do
  it 'should read binary' do
    action = OFActionEnqueue.read [
      0, 11, 0, 16,     # header
      0, 1,             # port
      0, 0, 0, 0, 0, 0, # padding
      0, 0, 0, 1        # queue_id
    ].pack('C*')
    expect(action.type).to eq(:enqueue)
    expect(action.len).to eq(16)
    expect(action.port).to eq(1)
    expect(action.queue_id).to eq(1)
  end
  it 'should initialize with default values' do
    action = OFActionEnqueue.new
    expect(action.type).to eq(:enqueue)
    expect(action.len).to eq(16)
    expect(action.port).to eq(:none)
    expect(action.queue_id).to eq(0)
  end
  it 'should initialize with some values' do
    action = OFActionEnqueue.new(port: 1, queue_id: 1)
    expect(action.type).to eq(:enqueue)
    expect(action.len).to eq(16)
    expect(action.port).to eq(1)
    expect(action.queue_id).to eq(1)
  end
end
