(Dir[File.expand_path '../../helpers/**/*.rb', __FILE__] +
 Dir[File.expand_path '../../structs/**/*.rb', __FILE__]).each do |file|
  require file
end

module OpenFlow
  module Protocol
    class Action < SuperclassBase
      HEADER_LENGTH = 4
      TYPES = [
        :output,
        :set_vlan_id,
        :set_vlan_pcp,
        :strip_vlan,
        :set_mac_source,       # set_dl_src
        :set_mac_destination,  # set_dl_dst
        :set_ip_source,        # set_nw_src
        :set_ip_destination,   # set_nw_dst
        :set_ip_tos,           # set_nw_tos
        :set_source_port,      # set_tp_src
        :set_destination_port, # set_tp_dst
        :enqueue
      ]
      TYPES[0xffff] = :vendor

      enum16 :type, list: TYPES, asserted_value: -> { type_str.to_sym }
      uint16 :len, value: -> { HEADER_LENGTH + body_length }
    end
  end
end
