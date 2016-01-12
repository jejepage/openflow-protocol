require 'openflow-protocol/messages/message'

module OpenFlow
  module Protocol
    class FeaturesReply < Message
      uint64 :datapath_id, initial_value: 0
      uint32 :n_buffers, initial_value: 0
      uint8 :n_tables, initial_value: 0
      uint24 :padding
      hide :padding
      flags32 :capabilities, list: [
        :flow_stats,
        :table_stats,
        :port_stats,
        :stp,
        :reserved,
        :ip_reasm,
        :queue_stats,
        :arp_match_ip
      ]
      flags32 :actions, list: [
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
      ]
      array :ports,
        type: :physical_port,
        initial_length: -> { (len - ports.rel_offset) / 48 }

      def body_length
        24 + ports.to_binary_s.length
      end
    end
  end
end
