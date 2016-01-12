require 'openflow-protocol/actions/action'

module OpenFlow
  module Protocol
    class ActionSetSourcePort < Action
      uint16 :port, initial_value: 0
      uint16 :padding
      hide :padding

      def body_length
        4
      end
    end
  end
end
