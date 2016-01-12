require 'spec_helper'

describe OFAggregateStatisticsRequest do
  it 'should read binary' do
    stats = OFAggregateStatisticsRequest.read [
      # match
      0, 0x30, 0x20, 0x4f, # wildcards
      0, 0,                # in_port
      0, 0, 0, 0, 0, 0,    # mac_source
      0, 0, 0, 0, 0, 0,    # mac_destination
      0xff, 0xff,          # vlan_id
      0,                   # vlan_pcp
      0,                   # padding
      8, 0,                # mac_protocol
      0,                   # ip_tos
      6,                   # ip_protocol
      0, 0,                # padding
      0, 0, 0, 0,          # ip_source
      192, 168, 0, 2,      # ip_destination
      0, 0,                # source_port
      0x0b, 0xb8,          # destination_port

      1,    # table_id
      0,    # padding
      0, 1  # out_port
    ].pack('C*')
    expect(stats.match.ip_destination).to eq('192.168.0.2')
    expect(stats.table_id).to eq(1)
    expect(stats.out_port).to eq(1)
  end
  it 'should initialize with default values' do
    stats = OFAggregateStatisticsRequest.new
    expect(stats.match.ip_destination).to eq('0.0.0.0')
    expect(stats.table_id).to eq(:all)
    expect(stats.out_port).to eq(:none)
  end
  it 'should initialize with some values' do
    stats = OFAggregateStatisticsRequest.new(
      table_id: 1,
      out_port: 1
    )
    expect(stats.match.ip_destination).to eq('0.0.0.0')
    expect(stats.table_id).to eq(1)
    expect(stats.out_port).to eq(1)
  end
end
