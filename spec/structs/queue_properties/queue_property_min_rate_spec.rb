require 'spec_helper'

describe OFQueuePropertyMinRate do
  it 'should read binary' do
    prop = OFQueuePropertyMinRate.read [
      0, 1, 0, 16, 0, 0, 0, 0, # header
      0, 100,                  # rate
      0, 0, 0, 0, 0, 0         # padding
    ].pack('C*')
    expect(prop.type).to eq(:min_rate)
    expect(prop.len).to eq(16)
    expect(prop.rate).to eq(100)
  end
  it 'should initialize with default values' do
    prop = OFQueuePropertyMinRate.new
    expect(prop.type).to eq(:min_rate)
    expect(prop.len).to eq(16)
    expect(prop.rate).to eq(0)
  end
  it 'should initialize with some values' do
    prop = OFQueuePropertyMinRate.new(rate: 100)
    expect(prop.type).to eq(:min_rate)
    expect(prop.len).to eq(16)
    expect(prop.rate).to eq(100)
  end
  it 'should disabled rate when > 1000' do
    prop = OFQueuePropertyMinRate.new(rate: 1001)
    expect(prop.type).to eq(:min_rate)
    expect(prop.len).to eq(16)
    expect(prop.rate).to eq(:disabled)
  end
end
