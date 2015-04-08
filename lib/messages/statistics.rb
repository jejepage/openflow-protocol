require_relative 'message'

class OFStatistics < OFMessage
  STATISTICS_TYPES = [
    :description,
    :flow,
    :aggregate,
    :table,
    :port,
    :queue
  ]
  STATISTICS_TYPES[0xffff] = :vendor

  def flags_list
    self.class.const_get(:FLAGS)
  end

  enum16 :statistic_type, list: STATISTICS_TYPES
  flags16 :flags, list: -> { flags_list }

  def body_length
    4 + statistics.to_binary_s.length
  end
end
