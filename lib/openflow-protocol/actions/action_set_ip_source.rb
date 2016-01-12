require 'openflow-protocol/actions/action'

module OpenFlow
  module Protocol
    class ActionSetIpSource < Action
      ipv4_address :ip_address

      def body_length
        4
      end
    end
  end
end
