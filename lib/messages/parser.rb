Dir[File.expand_path '*.rb', __dir__].each do |file|
  require_relative file
end

class OFParser
  def self.read(binary)
    type       = OFMessage::TYPES[binary[1].unpack('C')[0].to_i]
    klass_name = 'OF' + type.to_s.split('_').map(&:capitalize).join
    klass      = Object.const_get(klass_name)
    klass.read(binary)
  end
end
