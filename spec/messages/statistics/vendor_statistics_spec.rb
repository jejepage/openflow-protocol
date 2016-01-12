require 'spec_helper'

describe OFVendorStatistics do
  it 'should read binary' do
    stats = OFVendorStatistics.read [
      0, 0, 0, 1, # vendor
      1, 2, 3, 4  # body
    ].pack('C*')
    expect(stats.vendor).to eq(1)
    expect(stats.body).to eq([1, 2, 3, 4].pack('C*'))
  end
  it 'should initialize with default values' do
    stats = OFVendorStatistics.new
    expect(stats.vendor).to eq(0)
    expect(stats.body).to be_empty
  end
  it 'should initialize with some values' do
    stats = OFVendorStatistics.new(
      vendor: 1,
      body: [1, 2, 3, 4].pack('C*')
    )
    expect(stats.vendor).to eq(1)
    expect(stats.body).to eq([1, 2, 3, 4].pack('C*'))
  end
end
