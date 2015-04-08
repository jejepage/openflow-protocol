require 'bindata'

def _def_flags(size)
  eval %(
    class Flags#{size} < BinData::Primitive
      mandatory_parameter :list

      endian :big
      uint#{size} :flags, initial_value: 0

      def get
        list.each_with_object([]) do |(key, value), result|
          result << key if (flags & value != 0) || (flags == value)
          result
        end
      end

      def set(value)
        value.each do |each|
          fail "Invalid flag: \#{value}" unless list.keys.include?(each)
        end
        self.flags = value.empty? ?
                     0 :
                     value.map { |each| list[each] }.inject(:|)
      end

      private

      def list
        list = eval_parameter(:list)
        case list
        when Array
          shift = 0
          list.each_with_object({}) do |each, result|
            result[each] = 1 << shift
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

_def_flags 8
_def_flags 16
_def_flags 32
