require 'bindata'

def _def_enum(size)
  eval %(
    class Enum#{size} < BinData::Primitive
      mandatory_parameter :list

      endian :big
      uint#{size} :enum, initial_value: 0

      def get
        list.invert.fetch(enum)
      rescue KeyError
        enum
      end

      def set(value)
        self.enum = list.fetch(value)
      rescue KeyError
        self.enum = value
      end

      private

      def list
        list = eval_parameter(:list)
        case list
        when Array
          shift = 0
          list.each_with_object({}) do |each, result|
            result[each] = shift
            shift += 1
            result
          end
        when Hash
          list
        end
      end
    end
  )
end

_def_enum 8
_def_enum 16
_def_enum 32
