require 'openflow-protocol/actions/action'

module OpenFlow
  module Protocol
    class ActionStripVlan < Action
      uint32 :padding
      hide :padding

      def body_length
        4
      end
    end
  end
end
