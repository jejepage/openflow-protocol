require 'bindata'

class OFVendorStatistics < BinData::Record
  endian :big
  uint32 :vendor, initial_value: 0
  rest :body
end
