require 'spec_helper'

describe OFAggregateStatisticsReply do
  it 'should read binary' do
    stats = OFAggregateStatisticsReply.read [
      0, 0, 0, 0, 0, 0, 0, 10, # packet_count
      0, 0, 0, 0, 0, 0, 0, 80, # byte_count
      0, 0, 0, 4,              # flow_count
      0, 0, 0, 0               # padding
    ].pack('C*')
    expect(stats.packet_count).to eq(10)
    expect(stats.byte_count).to eq(80)
    expect(stats.flow_count).to eq(4)
  end
  it 'should initialize with default values' do
    stats = OFAggregateStatisticsReply.new
    expect(stats.packet_count).to eq(0)
    expect(stats.byte_count).to eq(0)
    expect(stats.flow_count).to eq(0)
  end
  it 'should initialize with some values' do
    stats = OFAggregateStatisticsReply.new(
      packet_count: 10,
      byte_count: 80,
      flow_count: 4
    )
    expect(stats.packet_count).to eq(10)
    expect(stats.byte_count).to eq(80)
    expect(stats.flow_count).to eq(4)
  end
end
