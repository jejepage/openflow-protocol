require 'openflow-protocol/messages/message'

module OpenFlow
  module Protocol
    class Vendor < Message
      uint32 :vendor, initial_value: 0
      rest :data

      def body_length
        4 + data.length
      end
    end
  end
end
