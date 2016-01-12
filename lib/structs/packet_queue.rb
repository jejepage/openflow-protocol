require_relative 'queue_properties/queue_properties'

class OFPacketQueue < BinData::Record
  endian :big
  uint32 :queue_id, initial_value: 0
  uint16 :len, value: -> { 8 + properties.to_binary_s.length }
  uint16 :padding
  hide :padding
  of_queue_properties :properties, length: -> { len - 8 }
end
