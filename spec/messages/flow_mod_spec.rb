describe FlowMod do
  let(:data) {
    [
      1, 14, 0, 80, 0, 0, 0, 1, # header

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

      0, 0, 0, 0, 0, 0, 0, 1, # cookie
      0, 0,                   # command
      0, 100,                 # idle_timeout
      1, 0x2c,                # hard_timeout
      0x0b, 0xb8,             # priority
      0, 0, 0, 1,             # buffer_id
      0, 0,                   # out_port
      0, 1,                   # flags

      # actions
      #   output
      0, 0, 0, 8, # header
      0, 1,       # port
      0xff, 0xff, # max_length
    ].pack('C*')
  }

  it 'should read binary' do
    msg = FlowMod.read(data)
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:flow_mod)
    expect(msg.len).to eq(80)
    expect(msg.xid).to eq(1)
    expect(msg.match.ip_destination).to eq('192.168.0.2')
    expect(msg.cookie).to eq(1)
    expect(msg.command).to eq(:add)
    expect(msg.idle_timeout).to eq(100)
    expect(msg.hard_timeout).to eq(300)
    expect(msg.priority).to eq(3000)
    expect(msg.buffer_id).to eq(1)
    expect(msg.out_port).to eq(0)
    expect(msg.flags).to eq([:send_flow_removed])
    expect(msg.actions.length).to eq(1)
    expect(msg.actions.first.type).to eq(:output)
  end
  it 'should be parsable' do
    msg = Parser.read(data)
    expect(msg.class).to eq(FlowMod)
  end
  it 'should initialize with default values' do
    msg = FlowMod.new
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:flow_mod)
    expect(msg.len).to eq(72)
    expect(msg.xid).to eq(0)
    expect(msg.match.ip_destination).to eq('0.0.0.0')
    expect(msg.cookie).to eq(0)
    expect(msg.command).to eq(:add)
    expect(msg.idle_timeout).to eq(0)
    expect(msg.hard_timeout).to eq(0)
    expect(msg.priority).to eq(0)
    expect(msg.buffer_id).to eq(:none)
    expect(msg.out_port).to eq(0)
    expect(msg.flags).to be_empty
    expect(msg.actions).to be_empty
  end
  it 'should initialize with some values' do
    msg = FlowMod.new(
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
          source_port: true
        },
        mac_protocol: :ipv4,
        ip_protocol: :tcp,
        ip_destination: '192.168.0.2',
        destination_port: 3000
      },
      cookie: 1,
      command: :add,
      idle_timeout: 100,
      hard_timeout: 300,
      priority: 3000,
      buffer_id: 1,
      flags: [:send_flow_removed],
      actions: [ActionOutput.new(port: 1)]
    )
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:flow_mod)
    expect(msg.len).to eq(80)
    expect(msg.xid).to eq(1)
    expect(msg.match.ip_destination).to eq('192.168.0.2')
    expect(msg.cookie).to eq(1)
    expect(msg.command).to eq(:add)
    expect(msg.idle_timeout).to eq(100)
    expect(msg.hard_timeout).to eq(300)
    expect(msg.priority).to eq(3000)
    expect(msg.buffer_id).to eq(1)
    expect(msg.out_port).to eq(0)
    expect(msg.flags).to eq([:send_flow_removed])
    expect(msg.actions.length).to eq(1)
    expect(msg.actions.first.type).to eq(:output)
  end
  it 'should initialize with some other values' do
    msg = FlowMod.new(
      xid: 1,
      cookie: 2,
      command: :delete
    )
    expect(msg.version).to eq(Message::OFP_VERSION)
    expect(msg.type).to eq(:flow_mod)
    expect(msg.len).to eq(72)
    expect(msg.xid).to eq(1)
    expect(msg.match.ip_destination).to eq('0.0.0.0')
    expect(msg.cookie).to eq(2)
    expect(msg.command).to eq(:delete)
    expect(msg.idle_timeout).to eq(0)
    expect(msg.hard_timeout).to eq(0)
    expect(msg.priority).to eq(0)
    expect(msg.buffer_id).to eq(:none)
    expect(msg.out_port).to eq(:none)
    expect(msg.flags).to be_empty
    expect(msg.actions).to be_empty
  end
end
