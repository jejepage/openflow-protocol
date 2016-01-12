require 'openflow-protocol/structs/port_number'

module OpenFlow
  module Protocol
    class PortStatisticsRequest < BinData::Record
      endian :big
      port_number :port_number, initial_value: -> { :none } # all ports
      uint48 :padding
      hide :padding
    end
  end
end
