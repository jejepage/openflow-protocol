require 'spec_helper'

describe OFActionSetIpDestination do
  it 'should read binary' do
    action = OFActionSetIpDestination.read [
      0, 7, 0, 8, # header
      10, 0, 0, 1 # ip_address
    ].pack('C*')
    expect(action.type).to eq(:set_ip_destination)
    expect(action.len).to eq(8)
    expect(action.ip_address).to eq('10.0.0.1')
  end
  it 'should initialize with default values' do
    action = OFActionSetIpDestination.new
    expect(action.type).to eq(:set_ip_destination)
    expect(action.len).to eq(8)
    expect(action.ip_address).to eq('0.0.0.0')
  end
  it 'should initialize with some values' do
    action = OFActionSetIpDestination.new(ip_address: '10.0.0.1')
    expect(action.type).to eq(:set_ip_destination)
    expect(action.len).to eq(8)
    expect(action.ip_address).to eq('10.0.0.1')
  end
end
