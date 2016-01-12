require 'openflow-protocol/actions/action'

module OpenFlow
  module Protocol
    class ActionSetVlanPcp < Action
      uint8 :vlan_pcp, initial_value: 0
      uint24 :padding
      hide :padding

      def body_length
        4
      end
    end
  end
end
