require 'openflow-protocol/messages/message'

module OpenFlow
  module Protocol
    class FlowMod < Message
      match :match
      uint64 :cookie, initial_value: 0
      enum16 :command, list: [:add, :modify, :modify_strict, :delete, :delete_strict]
      uint16 :idle_timeout, initial_value: 0
      uint16 :hard_timeout, initial_value: 0
      uint16 :priority, initial_value: 0
      enum32 :buffer_id, list: {none: 0xffffffff}, initial_value: -> { :none }
      port_number :out_port, initial_value: (lambda do
        /^delete/ =~ command.to_s ? :none : 0
      end)
      flags16 :flags, list: [:send_flow_removed, :check_overlapping, :emergency]
      actions :actions, length: -> { len - actions.rel_offset }

      def body_length
        64 + actions.to_binary_s.length
      end
    end
  end
end
