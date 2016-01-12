require_relative 'table_statistics'

class OFFlowStatisticsRequest < BinData::Record
  endian :big
  of_match :match
  enum8 :table_id, list: OFTableStatistics::TABLE_IDS, initial_value: -> { :all }
  uint8 :padding
  hide :padding
  of_port_number :out_port, initial_value: -> { :none }
end
