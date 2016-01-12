require 'openflow-protocol/structs/port_number'

module OpenFlow
  module Protocol
    class QueueStatisticsRequest < BinData::Record
      endian :big
      port_number :port_number, initial_value: -> { :all }
      uint16 :padding
      hide :padding
      enum32 :queue_id, list: {all: 0xffffffff}, initial_value: -> { :all }
    end
  end
end
