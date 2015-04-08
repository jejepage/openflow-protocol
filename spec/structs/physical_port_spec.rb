require 'spec_helper'

describe OFPhysicalPort do
  it 'should read binary' do
    phy_port = OFPhysicalPort.read [
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
    expect(phy_port.port_number).to eq(1)
    expect(phy_port.hardware_address).to eq('00:00:00:00:00:01')
    expect(phy_port.name).to eq('port-1')
    expect(phy_port.config).to eq([:port_down])
    expect(phy_port.state).to eq([:link_down])
    expect(phy_port.current_features).to eq(OFPhysicalPort::FEATURES)
    expect(phy_port.advertised_features).to eq(OFPhysicalPort::FEATURES)
    expect(phy_port.supported_features).to eq(OFPhysicalPort::FEATURES)
    expect(phy_port.peer_features).to eq(OFPhysicalPort::FEATURES)
  end
  it 'should initialize with default values' do
    phy_port = OFPhysicalPort.new
    expect(phy_port.port_number).to eq(0)
    expect(phy_port.hardware_address).to eq('00:00:00:00:00:00')
    expect(phy_port.name).to eq('')
    expect(phy_port.config).to be_empty
    expect(phy_port.state).to eq([:spanning_tree_listen])
    expect(phy_port.current_features).to be_empty
    expect(phy_port.advertised_features).to be_empty
    expect(phy_port.supported_features).to be_empty
    expect(phy_port.peer_features).to be_empty
  end
  it 'should initialize with some values' do
    phy_port = OFPhysicalPort.new(
      port_number: 1,
      hardware_address: '00:00:00:00:00:01',
      name: 'port-1',
      config: [:port_down],
      state: [:link_down],
      current_features: OFPhysicalPort::FEATURES,
      advertised_features: OFPhysicalPort::FEATURES,
      supported_features: OFPhysicalPort::FEATURES,
      peer_features: OFPhysicalPort::FEATURES
    )
    expect(phy_port.port_number).to eq(1)
    expect(phy_port.hardware_address).to eq('00:00:00:00:00:01')
    expect(phy_port.name).to eq('port-1')
    expect(phy_port.config).to eq([:port_down])
    expect(phy_port.state).to eq([:link_down])
    expect(phy_port.current_features).to eq(OFPhysicalPort::FEATURES)
    expect(phy_port.advertised_features).to eq(OFPhysicalPort::FEATURES)
    expect(phy_port.supported_features).to eq(OFPhysicalPort::FEATURES)
    expect(phy_port.peer_features).to eq(OFPhysicalPort::FEATURES)
  end
end
