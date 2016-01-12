require_relative '../../structs/port_number'

class OFQueueStatisticsRequest < BinData::Record
  endian :big
  of_port_number :port_number, initial_value: -> { :all }
  uint16 :padding
  hide :padding
  enum32 :queue_id, list: {all: 0xffffffff}, initial_value: -> { :all }
end
