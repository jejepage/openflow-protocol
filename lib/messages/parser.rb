require 'stringio'

Dir[File.expand_path '*.rb', __dir__].each do |file|
  require_relative file
end

class OFParser
  def self.read(io)
    io = StringIO.new(io) if io.is_a?(String)

    header = io.readpartial(OFMessage::HEADER_LENGTH)

    type       = OFMessage::TYPES[header[1].unpack('C')[0].to_i]
    klass_name = 'OF' + type.to_s.split('_').map(&:capitalize).join
    klass      = Object.const_get(klass_name)
    length     = header[2..3].unpack('S>')[0].to_i

    body = io.readpartial(length - OFMessage::HEADER_LENGTH)

    klass.read(header + body)
  end
end
