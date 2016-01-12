require 'openflow-protocol/messages/message'

module OpenFlow
  module Protocol
    class EchoRequest < Message
      rest :data

      def body_length
        data.length
      end
    end
  end
end
