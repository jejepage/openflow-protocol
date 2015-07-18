require 'bindata-contrib'
require_relative 'port_number'

class OFPhysicalPort < BinData::Record
  CONFIG = [
    :port_down,
    :no_spanning_tree,
    :no_receive,
    :no_receive_spanning_tree,
    :no_flood,
    :no_forward,
    :no_packet_in
  ]
  STATE = {
    link_down:             1 << 0,
    spanning_tree_listen:  0 << 8,
    spanning_tree_learn:   1 << 8,
    spanning_tree_forward: 2 << 8,
    spanning_tree_block:   3 << 8
  }
  FEATURES = [
    :port_10mb_half_duplex,
    :port_10mb_full_duplex,
    :port_100mb_half_duplex,
    :port_100mb_full_duplex,
    :port_1gb_half_duplex,
    :port_1gb_full_duplex,
    :port_10gb_full_duplex,
    :port_copper,
    :port_fiber,
    :port_auto_negotiation,
    :port_pause,
    :port_pause_asymmetric
  ]

  endian :big
  of_port_number :port_number, initial_value: 0
  mac_address :hardware_address
  string :name, length: 16, trim_padding: true, initial_value: ''
  flags32 :config, list: CONFIG
  flags32 :state, list: STATE
  flags32 :current_features, list: FEATURES
  flags32 :advertised_features, list: FEATURES
  flags32 :supported_features, list: FEATURES
  flags32 :peer_features, list: FEATURES
end
