describe FlowRemoved do
  let(:data) {
    [
      1, 11, 0, 88, 0, 0, 0, 1, # header

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

      0, 0, 0, 0, 0, 0, 0, 1,  # cookie
      0x0b, 0xb8,              # priority
      0,                       # reason
      0,                       # padding
      0, 0, 0, 50,             # duration_seconds
      0, 0, 0, 10,             # duration_nanoseconds
      0, 100,                  # idle_timeout
      0, 0,                    # padding
      0, 0, 0, 0, 0, 0, 0, 10, # packet_count
      0, 0, 0, 0, 0, 0, 0, 80  # byte_count
    ].pack('C*')
  }

  it 'should read binary' do
    msg = FlowRemoved.read(data)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:flow_removed)
    expect(msg.len).to eq(88)
    expect(msg.xid).to eq(1)
    expect(msg.match.ip_destination).to eq('192.168.0.2')
    expect(msg.cookie).to eq(1)
    expect(msg.priority).to eq(3000)
    expect(msg.reason).to eq(:idle_timeout)
    expect(msg.duration_seconds).to eq(50)
    expect(msg.duration_nanoseconds).to eq(10)
    expect(msg.idle_timeout).to eq(100)
    expect(msg.packet_count).to eq(10)
    expect(msg.byte_count).to eq(80)
  end
  it 'should be parsable' do
    msg = Parser.read(data)
    expect(msg.class).to eq(FlowRemoved)
  end
  it 'should initialize with default values' do
    msg = FlowRemoved.new
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:flow_removed)
    expect(msg.len).to eq(88)
    expect(msg.xid).to eq(0)
    expect(msg.match.ip_destination).to eq('0.0.0.0')
    expect(msg.cookie).to eq(0)
    expect(msg.priority).to eq(0)
    expect(msg.reason).to eq(:idle_timeout)
    expect(msg.duration_seconds).to eq(0)
    expect(msg.duration_nanoseconds).to eq(0)
    expect(msg.idle_timeout).to eq(0)
    expect(msg.packet_count).to eq(0)
    expect(msg.byte_count).to eq(0)
  end
  it 'should initialize with some values' do
    msg = FlowRemoved.new(
      xid: 1,
      match: {
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
        mac_protocol: :ipv4,
        ip_protocol: :tcp,
        ip_destination: '192.168.0.2',
        destination_port: 3000
      },
      cookie: 1,
      priority: 3000,
      reason: :idle_timeout,
      duration_seconds: 50,
      duration_nanoseconds: 10,
      idle_timeout: 100,
      packet_count: 10,
      byte_count: 80
    )
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:flow_removed)
    expect(msg.len).to eq(88)
    expect(msg.xid).to eq(1)
    expect(msg.match.ip_destination).to eq('192.168.0.2')
    expect(msg.cookie).to eq(1)
    expect(msg.priority).to eq(3000)
    expect(msg.reason).to eq(:idle_timeout)
    expect(msg.duration_seconds).to eq(50)
    expect(msg.duration_nanoseconds).to eq(10)
    expect(msg.idle_timeout).to eq(100)
    expect(msg.packet_count).to eq(10)
    expect(msg.byte_count).to eq(80)
  end
end
