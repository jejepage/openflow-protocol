require 'openflow-protocol/messages/statistics'

module OpenFlow
  module Protocol
    class StatisticsReply < Statistics
      FLAGS = [:reply_more]

      choice :statistics, selection: -> { statistic_type.to_s } do
        description_statistics 'description'
        flow_statistics_reply 'flow'
        aggregate_statistics_reply 'aggregate'
        array 'table',
          type: :table_statistics,
          initial_length: -> { (len - statistics.rel_offset) / 64 }
        array 'port',
          type: :port_statistics_reply,
          initial_length: -> { (len - statistics.rel_offset) / 104 }
        array 'queue',
          type: :queue_statistics_reply,
          initial_length: -> { (len - statistics.rel_offset) / 32 }
        vendor_statistics 'vendor'
        rest :default
      end
    end
  end
end
