require 'openflow-protocol/actions/action'

module OpenFlow
  module Protocol
    class ActionOutput < Action
      port_number :port
      uint16 :max_length, initial_value: 0xffff

      def body_length
        4
      end
    end
  end
end
