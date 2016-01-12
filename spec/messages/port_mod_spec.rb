require 'spec_helper'

describe OFPortMod do
  let(:data) {
    [
      1, 15, 0, 32, 0, 0, 0, 1, # header
      0, 1,                     # port_number
      0, 0, 0, 0, 0, 1,         # hardware_address
      0, 0, 0, 3,               # config
      0, 0, 0, 1,               # mask
      0, 0, 0, 3,               # advertise
      0, 0, 0, 0                # padding
    ].pack('C*')
  }

  it 'should read binary' do
    msg = OFPortMod.read(data)
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:port_mod)
    expect(msg.len).to eq(32)
    expect(msg.xid).to eq(1)
    expect(msg.port_number).to eq(1)
    expect(msg.hardware_address).to eq('00:00:00:00:00:01')
    expect(msg.config).to eq([:port_down, :no_spanning_tree])
    expect(msg.mask).to eq([:port_down])
    expect(msg.advertise).to eq([
      :port_10mb_half_duplex,
      :port_10mb_full_duplex
    ])
  end
  it 'should be parsable' do
    msg = OFParser.read(data)
    expect(msg.class).to eq(OFPortMod)
  end
  it 'should initialize with default values' do
    msg = OFPortMod.new
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:port_mod)
    expect(msg.len).to eq(32)
    expect(msg.xid).to eq(0)
    expect(msg.port_number).to eq(:none)
    expect(msg.hardware_address).to eq('00:00:00:00:00:00')
    expect(msg.config).to be_empty
    expect(msg.mask).to be_empty
    expect(msg.advertise).to be_empty
  end
  it 'should initialize with some values' do
    msg = OFPortMod.new(
      xid: 1,
      port_number: 1,
      hardware_address: '00:00:00:00:00:01',
      config: [:port_down, :no_spanning_tree],
      mask: [:port_down],
      advertise: [
        :port_10mb_half_duplex,
        :port_10mb_full_duplex
      ]
    )
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:port_mod)
    expect(msg.len).to eq(32)
    expect(msg.xid).to eq(1)
    expect(msg.port_number).to eq(1)
    expect(msg.hardware_address).to eq('00:00:00:00:00:01')
    expect(msg.config).to eq([:port_down, :no_spanning_tree])
    expect(msg.mask).to eq([:port_down])
    expect(msg.advertise).to eq([
      :port_10mb_half_duplex,
      :port_10mb_full_duplex
    ])
  end
end
