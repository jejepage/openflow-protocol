require 'openflow-protocol/actions/action'

module OpenFlow
  module Protocol
    class ActionSetMacSource < Action
      mac_address :mac_address
      uint48 :padding
      hide :padding

      def body_length
        12
      end
    end
  end
end
