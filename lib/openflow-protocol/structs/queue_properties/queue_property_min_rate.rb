require 'openflow-protocol/structs/queue_properties/queue_property'

module OpenFlow
  module Protocol
    class QueuePropertyMinRate < QueueProperty
      class Rate < BinData::Primitive
        endian :big
        uint16 :rate, initial_value: 0

        def get
          return :disabled if rate > 1000
          rate
        end

        def set(value)
          value = 0xffff if value == :disabled
          self.rate = value
        end
      end

      rate :rate
      uint48 :padding2
      hide :padding2

      def body_length
        8
      end
    end
  end
end
