require 'openflow-protocol/actions/action'

module OpenFlow
  module Protocol
    class ActionVendor < Action
      uint32 :vendor, initial_value: 0

      def body_length
        4
      end
    end
  end
end
