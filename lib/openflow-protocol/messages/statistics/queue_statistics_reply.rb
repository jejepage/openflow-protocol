require 'openflow-protocol/structs/port_number'

module OpenFlow
  module Protocol
    class QueueStatisticsReply < BinData::Record
      endian :big
      port_number :port_number, initial_value: 0
      uint16 :padding
      hide :padding
      uint32 :queue_id, initial_value: 0
      uint64 :transmit_bytes, initial_value: 0
      uint64 :transmit_packets, initial_value: 0
      uint64 :transmit_errors, initial_value: 0
    end
  end
end
