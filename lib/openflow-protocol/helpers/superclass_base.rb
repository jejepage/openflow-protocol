require 'bindata-contrib'

module OpenFlow
  module Protocol
    class SuperclassBase < BinData::Record
      attr_reader :type_str

      endian :big

      def initialize_instance
        super
        name = self.class.name.split('::').last
        if name[0..5] == 'Action'
          name = name[6..-1]
        elsif name[0..12] == 'QueueProperty'
          name = name[13..-1]
        end
        @type_str = name.gsub(/([A-Z])/, '_\1')[1..-1].downcase
      end

      def body_length
        0
      end
    end
  end
end
