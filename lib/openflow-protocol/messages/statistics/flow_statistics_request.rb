require 'openflow-protocol/messages/statistics/table_statistics'

module OpenFlow
  module Protocol
    class FlowStatisticsRequest < BinData::Record
      endian :big
      match :match
      enum8 :table_id, list: TableStatistics::TABLE_IDS, initial_value: -> { :all }
      uint8 :padding
      hide :padding
      port_number :out_port, initial_value: -> { :none }
    end
  end
end
