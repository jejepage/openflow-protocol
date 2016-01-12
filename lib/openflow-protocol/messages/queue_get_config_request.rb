require 'openflow-protocol/messages/message'

module OpenFlow
  module Protocol
    class QueueGetConfigRequest < Message
      port_number_strict :port
      uint16 :padding
      hide :padding

      def body_length
        4
      end
    end
  end
end
