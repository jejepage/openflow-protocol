require 'spec_helper'

describe OFPortStatisticsRequest do
  it 'should read binary' do
    stats = OFPortStatisticsRequest.read [
      0, 1,            # port_number
      0, 0, 0, 0, 0, 0 # padding
    ].pack('C*')
    expect(stats.port_number).to eq(1)
  end
  it 'should initialize with default values' do
    stats = OFPortStatisticsRequest.new
    expect(stats.port_number).to eq(:none)
  end
  it 'should initialize with some values' do
    stats = OFPortStatisticsRequest.new(port_number: 1)
    expect(stats.port_number).to eq(1)
  end
end
