require 'bindata'

module OpenFlow
  module Protocol
    class AggregateStatisticsReply < BinData::Record
      endian :big
      uint64 :packet_count, initial_value: 0
      uint64 :byte_count, initial_value: 0
      uint32 :flow_count, initial_value: 0
      uint32 :padding
      hide :padding
    end
  end
end
