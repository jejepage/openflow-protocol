require 'bindata'

class ArrayOfSubclasses < BinData::Primitive
  default_parameter length: 0
  endian :big
  string :binary, read_length: :length

  def get
    items = []
    tmp = binary
    until tmp.empty?
      type_index = BinData::Uint16be.read(tmp)
      type_str = types.fetch(type_index)
      class_name = name + type_str.to_s.split('_').map(&:capitalize).join
      klass = Object.const_get class_name
      item = klass.read(tmp)
      items << item
      tmp = tmp[item.len..-1]
    end
    items
  end

  def set(value)
    self.binary = value.map(&:to_binary_s).join
  end

  private

  def name
    plural = self.class.to_s
    return plural[0..-4] + 'y' if plural[-3..-1] == 'ies'
    plural[0..-2]
  end

  def types
    Object.const_get(name + '::TYPES')
  end
end
