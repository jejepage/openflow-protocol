require 'openflow-protocol/structs/queue_properties/queue_properties'

module OpenFlow
  module Protocol
    class PacketQueue < BinData::Record
      endian :big
      uint32 :queue_id, initial_value: 0
      uint16 :len, value: -> { 8 + properties.to_binary_s.length }
      uint16 :padding
      hide :padding
      queue_properties :properties, length: -> { len - 8 }
    end
  end
end
