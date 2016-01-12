require 'openflow-protocol/messages/message'

module OpenFlow
  module Protocol
    class PortMod < Message
      port_number :port_number
      mac_address :hardware_address
      flags32 :config, list: PhysicalPort::CONFIG
      flags32 :mask, list: PhysicalPort::CONFIG
      flags32 :advertise, list: PhysicalPort::FEATURES
      uint32 :padding
      hide :padding

      def body_length
        24
      end
    end
  end
end
