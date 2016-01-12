require 'spec_helper'

describe OFQueuePropertyNone do
  it 'should read binary' do
    prop = OFQueuePropertyNone.read [0, 0, 0, 8, 0, 0, 0, 0].pack('C*')
    expect(prop.type).to eq(:none)
    expect(prop.len).to eq(8)
  end
  it 'should initialize with default values' do
    prop = OFQueuePropertyNone.new
    expect(prop.type).to eq(:none)
    expect(prop.len).to eq(8)
  end
end
