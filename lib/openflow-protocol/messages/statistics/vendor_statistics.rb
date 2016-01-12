require 'bindata'

module OpenFlow
  module Protocol
    class VendorStatistics < BinData::Record
      endian :big
      uint32 :vendor, initial_value: 0
      rest :body
    end
  end
end
