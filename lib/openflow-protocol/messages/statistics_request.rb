require 'openflow-protocol/messages/statistics'

module OpenFlow
  module Protocol
    class StatisticsRequest < Statistics
      FLAGS = []

      choice :statistics, selection: -> { statistic_type.to_s } do
        flow_statistics_request 'flow'
        aggregate_statistics_request 'aggregate'
        port_statistics_request 'port'
        queue_statistics_request 'queue'
        vendor_statistics 'vendor'
        rest :default
      end
    end
  end
end
