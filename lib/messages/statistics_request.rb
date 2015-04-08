require_relative 'statistics'

class OFStatisticsRequest < OFStatistics
  FLAGS = []

  choice :statistics, selection: -> { statistic_type.to_s } do
    of_flow_statistics_request 'flow'
    of_aggregate_statistics_request 'aggregate'
    of_port_statistics_request 'port'
    of_queue_statistics_request 'queue'
    of_vendor_statistics 'vendor'
    rest :default
  end
end
