describe OpenFlow::Protocol::FeaturesReply do
  let(:data) {
    [
      1, 6, 0, 128, 0, 0, 0, 1, # header
      0, 0, 0, 0, 0, 0, 0, 42,  # datapath_id
      0, 0, 0, 10,              # n_buffers
      5,                        # n_tables
      0, 0, 0,                  # padding
      0, 0, 0, 0xff,            # capabilities
      0, 0, 0x0f, 0xff,         # actions
      # port 1
      0, 1,               # port_number
      0, 0, 0, 0, 0, 1,   # hardware_address
      112, 111, 114, 116, # name
      45, 49, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 1,         # config
      0, 0, 0, 1,         # state
      0, 0, 0x0f, 0xff,   # current_features
      0, 0, 0x0f, 0xff,   # advertised_features
      0, 0, 0x0f, 0xff,   # supported_features
      0, 0, 0x0f, 0xff,   # peer_features
      # port 2
      0, 2,               # port_number
      0, 0, 0, 0, 0, 2,   # hardware_address
      112, 111, 114, 116, # name
      45, 50, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 1,         # config
      0, 0, 0, 1,         # state
      0, 0, 0x0f, 0xff,   # current_features
      0, 0, 0x0f, 0xff,   # advertised_features
      0, 0, 0x0f, 0xff,   # supported_features
      0, 0, 0x0f, 0xff    # peer_features
    ].pack('C*')
  }
  let(:real_data) {
    [
      1, 6, 0, 176, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 1,
      0, 0, 1, 0,
      255,
      0, 0, 0,
      0, 0, 0, 199,
      0, 0, 15, 255,
      # port-2
      0, 2,
      90, 50, 48, 40, 143, 254,
      115, 49, 45, 101,
      116, 104, 50, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 192,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      # port-local
      255, 254,
      226, 183, 195, 44, 245, 74,
      115, 49, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 1,
      0, 0, 0, 1,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      # port-1
      0, 1,
      42, 94, 179, 106, 57, 71,
      115, 49, 45, 101,
      116, 104, 49, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 1,
      0, 0, 0, 192,
      0, 0, 0, 0,
      0, 0, 0, 0,
      0, 0, 0, 0
    ].pack('C*')
  }

  it 'should read binary' do
    msg = OpenFlow::Protocol::FeaturesReply.read(data)
    expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
    expect(msg.type).to eq(:features_reply)
    expect(msg.len).to eq(128)
    expect(msg.xid).to eq(1)
    expect(msg.datapath_id).to eq(42)
    expect(msg.n_buffers).to eq(10)
    expect(msg.n_tables).to eq(5)
    expect(msg.capabilities).to eq([
      :flow_stats,
      :table_stats,
      :port_stats,
      :stp,
      :reserved,
      :ip_reasm,
      :queue_stats,
      :arp_match_ip
    ])
    expect(msg.actions).to eq([
      :output,
      :set_vlan_vid,
      :set_vlan_pcp,
      :strip_vlan,
      :set_dl_src,
      :set_dl_dst,
      :set_nw_src,
      :set_nw_dst,
      :set_nw_tos,
      :set_tp_src,
      :set_tp_dst,
      :enqueue
    ])
    expect(msg.ports.length).to eq(2)
    expect(msg.ports[0].port_number).to eq(1)
    expect(msg.ports[1].port_number).to eq(2)
  end
  it 'should be parsable' do
    msg = OpenFlow::Protocol::Parser.read(data)
    expect(msg.class).to eq(OpenFlow::Protocol::FeaturesReply)
  end
  it 'should read a real binary message' do
    msg = OpenFlow::Protocol::FeaturesReply.read(real_data)
    expect(msg.ports.length).to eq(3)
  end
  it 'should initialize with default values' do
    msg = OpenFlow::Protocol::FeaturesReply.new
    expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
    expect(msg.type).to eq(:features_reply)
    expect(msg.len).to eq(32)
    expect(msg.xid).to eq(0)
    expect(msg.datapath_id).to eq(0)
    expect(msg.n_buffers).to eq(0)
    expect(msg.n_tables).to eq(0)
    expect(msg.capabilities).to eq([])
    expect(msg.actions).to eq([])
    expect(msg.ports).to be_empty
  end
  it 'should initialize with some values' do
    msg = OpenFlow::Protocol::FeaturesReply.new(
      xid: 1,
      datapath_id: 42,
      n_buffers: 10,
      n_tables: 5,
      capabilities: [
        :flow_stats,
        :table_stats,
        :port_stats,
        :stp,
        :reserved,
        :ip_reasm,
        :queue_stats,
        :arp_match_ip
      ],
      actions: [
        :output,
        :set_vlan_vid,
        :set_vlan_pcp,
        :strip_vlan,
        :set_dl_src,
        :set_dl_dst,
        :set_nw_src,
        :set_nw_dst,
        :set_nw_tos,
        :set_tp_src,
        :set_tp_dst,
        :enqueue
      ],
      ports: [OpenFlow::Protocol::PhysicalPort.new]
    )
    expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
    expect(msg.type).to eq(:features_reply)
    expect(msg.len).to eq(80)
    expect(msg.xid).to eq(1)
    expect(msg.datapath_id).to eq(42)
    expect(msg.n_buffers).to eq(10)
    expect(msg.n_tables).to eq(5)
    expect(msg.capabilities).to eq([
      :flow_stats,
      :table_stats,
      :port_stats,
      :stp,
      :reserved,
      :ip_reasm,
      :queue_stats,
      :arp_match_ip
    ])
    expect(msg.actions).to eq([
      :output,
      :set_vlan_vid,
      :set_vlan_pcp,
      :strip_vlan,
      :set_dl_src,
      :set_dl_dst,
      :set_nw_src,
      :set_nw_dst,
      :set_nw_tos,
      :set_tp_src,
      :set_tp_dst,
      :enqueue
    ])
    expect(msg.ports.length).to eq(1)
  end
end
