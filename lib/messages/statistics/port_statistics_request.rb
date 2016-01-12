require_relative '../../structs/port_number'

class OFPortStatisticsRequest < BinData::Record
  endian :big
  of_port_number :port_number, initial_value: -> { :none } # all ports
  uint48 :padding
  hide :padding
end
