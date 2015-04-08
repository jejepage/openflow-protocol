require_relative 'statistics'

class OFStatisticsReply < OFStatistics
  FLAGS = [:reply_more]

  choice :statistics, selection: -> { statistic_type.to_s } do
    of_description_statistics 'description'
    of_flow_statistics_reply 'flow'
    of_aggregate_statistics_reply 'aggregate'
    array 'table',
      type: :of_table_statistics,
      initial_length: -> { (len - statistics.rel_offset) / 64 }
    array 'port',
      type: :of_port_statistics_reply,
      initial_length: -> { (len - statistics.rel_offset) / 104 }
    array 'queue',
      type: :of_queue_statistics_reply,
      initial_length: -> { (len - statistics.rel_offset) / 32 }
    of_vendor_statistics 'vendor'
    rest :default
  end
end
