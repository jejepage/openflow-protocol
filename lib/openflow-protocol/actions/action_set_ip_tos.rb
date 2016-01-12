require 'openflow-protocol/actions/action'

module OpenFlow
  module Protocol
    class ActionSetIpTos < Action
      uint8 :tos
      uint24 :padding
      hide :padding

      def body_length
        4
      end
    end
  end
end
