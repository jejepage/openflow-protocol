require 'openflow-protocol/messages/message'

module OpenFlow
  module Protocol
    class PortStatus < Message
      REASONS = [:add, :delete, :modify]

      enum8 :reason, list: REASONS
      uint56 :padding
      hide :padding
      physical_port :desc

      def body_length
        56
      end
    end
  end
end
