require 'openflow-protocol/messages/message'

module OpenFlow
  module Protocol
    class QueueGetConfigReply < Message
      port_number_strict :port
      uint48 :padding
      hide :padding
      array :queues,
        type: :packet_queue,
        read_until: :eof

      def body_length
        8 + queues.to_binary_s.length
      end
    end
  end
end
