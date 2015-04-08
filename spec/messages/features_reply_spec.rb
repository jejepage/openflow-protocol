require 'spec_helper'

describe OFFeaturesReply do
  it 'should read binary' do
    msg = OFFeaturesReply.read [
      1, 6, 0, 80, 0, 0, 0, 1, # header
      0, 0, 0, 0, 0, 0, 0, 42, # datapath_id
      0, 0, 0, 10,             # n_buffers
      5,                       # n_tables
      0, 0, 0,                 # padding
      0, 0, 0, 0xff,           # capabilities
      0, 0, 0x0f, 0xff,        # actions
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
      0, 0, 0x0f, 0xff    # peer_features
    ].pack('C*')
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
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
  it 'should initialize with default values' do
    msg = OFFeaturesReply.new
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
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
    msg = OFFeaturesReply.new(
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
      ports: [OFPhysicalPort.new]
    )
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
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
