require 'spec_helper'

describe OFMatch do
  it 'should read binary' do
    match = OFMatch.read [
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
      0x0b, 0xb8           # destination_port
    ].pack('C*')
    expect(match.wildcards).to eq(
      in_port: true,
      vlan_id: true,
      mac_source: true,
      mac_destination: true,
      source_port: true,
      ip_source_all: true,
      vlan_pcp: true,
      ip_tos: true
    )
    expect(match.in_port).to eq(0)
    expect(match.mac_source).to eq('00:00:00:00:00:00')
    expect(match.mac_destination).to eq('00:00:00:00:00:00')
    expect(match.vlan_id).to eq(0xffff)
    expect(match.vlan_pcp).to eq(0)
    expect(match.mac_protocol).to eq(:ip)
    expect(match.ip_tos).to eq(0)
    expect(match.ip_protocol).to eq(:tcp)
    expect(match.ip_source).to eq('0.0.0.0')
    expect(match.ip_destination).to eq('192.168.0.2')
    expect(match.source_port).to eq(0)
    expect(match.destination_port).to eq(3000)
  end
  it 'should initialize with default values' do
    match = OFMatch.new
    expect(match.wildcards).to eq(OFMatch::Wildcards::ALL_FLAGS)
    expect(match.in_port).to eq(0)
    expect(match.mac_source).to eq('00:00:00:00:00:00')
    expect(match.mac_destination).to eq('00:00:00:00:00:00')
    expect(match.vlan_id).to eq(0xffff)
    expect(match.vlan_pcp).to eq(0)
    expect(match.mac_protocol).to eq(0)
    expect(match.ip_tos).to eq(0)
    expect(match.ip_protocol).to eq(0)
    expect(match.ip_source).to eq('0.0.0.0')
    expect(match.ip_destination).to eq('0.0.0.0')
    expect(match.source_port).to eq(0)
    expect(match.destination_port).to eq(0)
  end
  it 'should initialize with some values' do
    match = OFMatch.new(
      wildcards: {
        in_port: true,
        mac_source: true,
        mac_destination: true,
        vlan_id: true,
        vlan_pcp: true,
        ip_tos: true,
        ip_source_all: true,
        ip_destination: 16,
        destination_port: true
      },
      mac_protocol: :ip,
      ip_protocol: :tcp,
      ip_destination: '192.168.0.2',
      destination_port: 3000
    )
    expect(match.wildcards).to eq(
      in_port: true,
      mac_source: true,
      mac_destination: true,
      vlan_id: true,
      vlan_pcp: true,
      ip_tos: true,
      ip_source_all: true,
      ip_destination: 16,
      destination_port: true
    )
    expect(match.in_port).to eq(0)
    expect(match.mac_source).to eq('00:00:00:00:00:00')
    expect(match.mac_destination).to eq('00:00:00:00:00:00')
    expect(match.vlan_id).to eq(0xffff)
    expect(match.vlan_pcp).to eq(0)
    expect(match.mac_protocol).to eq(:ip)
    expect(match.ip_tos).to eq(0)
    expect(match.ip_protocol).to eq(:tcp)
    expect(match.ip_source).to eq('0.0.0.0')
    expect(match.ip_destination).to eq('192.168.0.2')
    expect(match.source_port).to eq(0)
    expect(match.destination_port).to eq(3000)
  end
  it 'should initialize with wildcards as array' do
    match = OFMatch.new(
      wildcards: [:in_port, :mac_source, :mac_destination]
    )
    expect(match.wildcards).to eq(
      in_port: true,
      mac_source: true,
      mac_destination: true
    )
  end
end
