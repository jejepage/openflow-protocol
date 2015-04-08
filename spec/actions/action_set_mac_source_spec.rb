require 'spec_helper'

describe OFActionSetMacSource do
  it 'should read binary' do
    action = OFActionSetMacSource.read [
      0, 4, 0, 16,      # header
      0, 0, 0, 0, 0, 1, # mac_address
      0, 0, 0, 0, 0, 0  # padding
    ].pack('C*')
    expect(action.type).to eq(:set_mac_source)
    expect(action.len).to eq(16)
    expect(action.mac_address).to eq('00:00:00:00:00:01')
  end
  it 'should initialize with default values' do
    action = OFActionSetMacSource.new
    expect(action.type).to eq(:set_mac_source)
    expect(action.len).to eq(16)
    expect(action.mac_address).to eq('00:00:00:00:00:00')
  end
  it 'should initialize with some values' do
    action = OFActionSetMacSource.new(mac_address: '00:00:00:00:00:01')
    expect(action.type).to eq(:set_mac_source)
    expect(action.len).to eq(16)
    expect(action.mac_address).to eq('00:00:00:00:00:01')
  end
end
