require 'spec_helper'

describe OFActionSetMacDestination do
  it 'should read binary' do
    action = OFActionSetMacDestination.read [
      0, 5, 0, 16,      # header
      0, 0, 0, 0, 0, 1, # mac_address
      0, 0, 0, 0, 0, 0  # padding
    ].pack('C*')
    expect(action.type).to eq(:set_mac_destination)
    expect(action.len).to eq(16)
    expect(action.mac_address).to eq('00:00:00:00:00:01')
  end
  it 'should initialize with default values' do
    action = OFActionSetMacDestination.new
    expect(action.type).to eq(:set_mac_destination)
    expect(action.len).to eq(16)
    expect(action.mac_address).to eq('00:00:00:00:00:00')
  end
  it 'should initialize with some values' do
    action = OFActionSetMacDestination.new(mac_address: '00:00:00:00:00:01')
    expect(action.type).to eq(:set_mac_destination)
    expect(action.len).to eq(16)
    expect(action.mac_address).to eq('00:00:00:00:00:01')
  end
end
