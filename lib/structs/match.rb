require 'English'
require_relative '../helpers/enum'
require_relative '../helpers/mac_address'
require_relative '../helpers/ip_address'
require_relative 'port_number'

class OFMatch < BinData::Record
  class Wildcards < BinData::Primitive
    FLAGS = {
      in_port:            1 <<  0,
      vlan_id:            1 <<  1,
      mac_source:         1 <<  2,
      mac_destination:    1 <<  3,
      mac_protocol:       1 <<  4,
      ip_protocol:        1 <<  5,
      source_port:        1 <<  6,
      destination_port:   1 <<  7,
      ip_source0:         1 <<  8,
      ip_source1:         1 <<  9,
      ip_source2:         1 << 10,
      ip_source3:         1 << 11,
      ip_source4:         1 << 12,
      ip_source_all:      1 << 13,
      ip_destination0:    1 << 14,
      ip_destination1:    1 << 15,
      ip_destination2:    1 << 16,
      ip_destination3:    1 << 17,
      ip_destination4:    1 << 18,
      ip_destination_all: 1 << 19,
      vlan_pcp:           1 << 20,
      ip_tos:             1 << 21
    }
    ALL_FLAGS = Hash[
      FLAGS.keys.select { |key| /^ip_(source|destination)\d$/ !~ key }
        .map { |key| [key, true] }
    ]

    endian :big
    uint32 :flags, initial_value: 0x003820ff # all

    def get
      FLAGS.each_with_object(Hash.new(0)) do |(key, bit), memo|
        next if flags & bit == 0
        if /^(ip_source|ip_destination)(\d)/ =~ key
          memo[$LAST_MATCH_INFO[1].to_sym] |= 1 << $LAST_MATCH_INFO[2].to_i
        else
          memo[key] = true
        end
      end
    end

    def set(value)
      self.flags = value.inject(0) do |memo, (key, val)|
        memo |
          case key
          when :ip_source, :ip_destination
            (val & 31) << (key == :ip_source ? 8 : 14)
          else
            val ? FLAGS.fetch(key) : 0
          end
      end
    end
  end

  endian :big
  wildcards :wildcards
  of_port_number :in_port, initial_value: 0
  mac_address :mac_source
  mac_address :mac_destination
  uint16 :vlan_id, initial_value: 0xffff
  uint8 :vlan_pcp, initial_value: 0
  uint8 :padding
  hide :padding
  enum16 :mac_protocol, list: {
    ip: 0x0800,
    arp: 0x0806,
    vlan: 0x8100
  }, initial_value: 0
  uint8 :ip_tos, initial_value: 0
  enum8 :ip_protocol, list: {
    icmp: 1,
    tcp: 6,
    udp: 17
  }, initial_value: 0
  uint16 :padding2
  hide :padding2
  ip_address :ip_source
  ip_address :ip_destination
  uint16 :source_port, initial_value: 0
  uint16 :destination_port, initial_value: 0
end
