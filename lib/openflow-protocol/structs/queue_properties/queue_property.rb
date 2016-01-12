Dir[File.expand_path '../../../helpers/**/*.rb', __FILE__].each do |file|
  require file
end

module OpenFlow
  module Protocol
    class QueueProperty < SuperclassBase
      HEADER_LENGTH = 8
      TYPES = [
        :none,
        :min_rate
      ]

      enum16 :type, list: TYPES, asserted_value: -> { type_str.to_sym }
      uint16 :len, value: -> { HEADER_LENGTH + body_length }
      uint32 :padding
      hide :padding
    end
  end
end
