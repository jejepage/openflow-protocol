Dir[File.expand_path 'action_*.rb', __dir__].each do |file|
  require file
end

class OFActions < BinData::Primitive
  default_parameter length: 0
  endian :big
  string :binary, read_length: :length

  def get
    actions = []
    tmp = binary
    until tmp.empty?
      type_index = BinData::Uint16be.read(tmp)
      type_str = OFAction::TYPES.fetch(type_index)
      class_name = 'OFAction' + type_str.to_s.split('_').map(&:capitalize).join
      klass = Object.const_get class_name
      action = klass.read(tmp)
      actions << action
      tmp = tmp[action.len..-1]
    end
    actions
  end

  def set(value)
    self.binary = value.map(&:to_binary_s).join
  end
end
