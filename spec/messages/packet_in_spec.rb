require 'spec_helper'

describe OFPacketIn do
  let(:data) {
    [
      1, 10, 0, 64, 0, 0, 0, 1, # header
      0, 0, 0, 1,               # buffer_id
      0, 46,                    # total_length
      0, 1,                     # in_port
      0,                        # reason
      0,                        # padding
      # 1, 2                      # data

      # ethernet
      0, 0, 0, 0, 0, 2, # mac_destination
      0, 0, 0, 0, 0, 1, # mac_source
      0x81, 0,          # protocol

      # vlan
      0x20, 1, # pcp & cfi & vlan_id
      8, 6,    # protocol

      # arp
      0, 1,             # hardware
      8, 0,             # protocol
      6,                # hardware_length
      4,                # protocol_length
      0, 2,             # operation
      0, 0, 0, 0, 0, 1, # mac_source
      192, 168, 0, 1,   # ip_source
      0, 0, 0, 0, 0, 2, # mac_destination
      192, 168, 0, 2    # ip_destination
    ].pack('C*')
  }

  it 'should read binary' do
    msg = OFPacketIn.read(data)
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:packet_in)
    expect(msg.len).to eq(64)
    expect(msg.xid).to eq(1)
    expect(msg.buffer_id).to eq(1)
    expect(msg.total_length).to eq(46)
    expect(msg.in_port).to eq(1)
    expect(msg.reason).to eq(:no_match)
    expect(msg.data.length).to eq(46)
    expect(msg.parsed_data.length).to eq(46)
    expect(msg.parsed_data.mac_destination).to eq('00:00:00:00:00:02')
  end
  it 'should be parsable' do
    msg = OFParser.read(data)
    expect(msg.class).to eq(OFPacketIn)
  end
  it 'should initialize with default values' do
    msg = OFPacketIn.new
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:packet_in)
    expect(msg.len).to eq(18)
    expect(msg.xid).to eq(0)
    expect(msg.buffer_id).to eq(:none)
    expect(msg.total_length).to eq(0)
    expect(msg.in_port).to eq(:none)
    expect(msg.reason).to eq(:no_match)
    expect(msg.data).to be_empty
  end
  it 'should initialize with some values' do
    msg = OFPacketIn.new(
      xid: 1,
      buffer_id: 1,
      in_port: 1,
      reason: :no_match,
      data: [1, 2].pack('C*')
    )
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:packet_in)
    expect(msg.len).to eq(20)
    expect(msg.xid).to eq(1)
    expect(msg.buffer_id).to eq(1)
    expect(msg.total_length).to eq(2)
    expect(msg.in_port).to eq(1)
    expect(msg.reason).to eq(:no_match)
    expect(msg.data.length).to eq(2)
  end
end
