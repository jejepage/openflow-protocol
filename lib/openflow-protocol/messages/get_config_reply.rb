require 'openflow-protocol/messages/message'

module OpenFlow
  module Protocol
    class GetConfigReply < Message
      FLAGS = [:fragments_normal, :fragments_drop, :fragments_reassemble]

      enum16 :flags, list: FLAGS
      uint16 :miss_send_length, initial_value: 0

      def body_length
        4
      end
    end
  end
end
