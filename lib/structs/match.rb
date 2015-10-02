require 'English'
require 'bindata-contrib'
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
      value = Hash[value.map { |v| [v, true] }] if value.is_a?(Array)
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

  def self.create(options = {})
    unless options[:wildcards]
      options[:wildcards] = {}
      %i(in_port vlan_id mac_source mac_destination mac_protocol ip_protocol source_port destination_port ip_source ip_destination vlan_pcp ip_tos).each do |flag|
        wild_flag = flag
        wild_flag = "#{flag}_all".to_sym if %i(ip_source ip_destination).include? flag
        options[:wildcards][wild_flag] = true unless options[flag]
      end
    end
    self.new options
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
    ipv4: 0x0800,
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
  ipv4_address :ip_source
  ipv4_address :ip_destination
  uint16 :source_port, initial_value: 0
  uint16 :destination_port, initial_value: 0
end
