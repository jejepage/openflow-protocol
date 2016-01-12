describe FlowStatisticsReply do
  it 'should read binary' do
    stats = FlowStatisticsReply.read [
      0, 96, # len
      1,     # table_id
      0,     # padding

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

      0, 0, 0, 50,             # duration_seconds
      0, 0, 0, 10,             # duration_nanoseconds
      0x0b, 0xb8,              # priority
      0, 100,                  # idle_timeout
      1, 0x2c,                 # hard_timeout
      0, 0, 0, 0, 0, 0,        # padding
      0, 0, 0, 0, 0, 0, 0, 1,  # cookie
      0, 0, 0, 0, 0, 0, 0, 10, # packet_count
      0, 0, 0, 0, 0, 0, 0, 80, # byte_count

      # actions
      #   output
      0, 0, 0, 8, # header
      0, 1,       # port
      0xff, 0xff # max_length
    ].pack('C*')
    expect(stats.len).to eq(96)
    expect(stats.table_id).to eq(1)
    expect(stats.match.ip_destination).to eq('192.168.0.2')
    expect(stats.duration_seconds).to eq(50)
    expect(stats.duration_nanoseconds).to eq(10)
    expect(stats.idle_timeout).to eq(100)
    expect(stats.hard_timeout).to eq(300)
    expect(stats.cookie).to eq(1)
    expect(stats.packet_count).to eq(10)
    expect(stats.byte_count).to eq(80)
    expect(stats.actions.length).to eq(1)
  end
  it 'should initialize with default values' do
    stats = FlowStatisticsReply.new
    expect(stats.len).to eq(88)
    expect(stats.table_id).to eq(:all)
    expect(stats.match.ip_destination).to eq('0.0.0.0')
    expect(stats.duration_seconds).to eq(0)
    expect(stats.duration_nanoseconds).to eq(0)
    expect(stats.idle_timeout).to eq(0)
    expect(stats.hard_timeout).to eq(0)
    expect(stats.cookie).to eq(0)
    expect(stats.packet_count).to eq(0)
    expect(stats.byte_count).to eq(0)
    expect(stats.actions).to be_empty
  end
  it 'should initialize with some values' do
    stats = FlowStatisticsReply.new(
    )

  end
end
