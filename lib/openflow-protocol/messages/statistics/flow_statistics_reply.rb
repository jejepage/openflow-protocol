require 'openflow-protocol/messages/statistics/table_statistics'

module OpenFlow
  module Protocol
    class FlowStatisticsReply < BinData::Record
      endian :big
      uint16 :len, initial_value: -> { 88 + actions.to_binary_s.length }
      enum8 :table_id, list: TableStatistics::TABLE_IDS, initial_value: -> { :all }
      uint8 :padding
      hide :padding
      match :match
      uint32 :duration_seconds, initial_value: 0
      uint32 :duration_nanoseconds, initial_value: 0
      uint16 :priority, initial_value: 0
      uint16 :idle_timeout, initial_value: 0
      uint16 :hard_timeout, initial_value: 0
      uint48 :padding2
      hide :padding2
      uint64 :cookie, initial_value: 0
      uint64 :packet_count, initial_value: 0
      uint64 :byte_count, initial_value: 0
      actions :actions, length: -> { len - actions.rel_offset }
    end
  end
end
