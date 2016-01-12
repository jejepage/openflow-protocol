require 'stringio'

Dir[File.expand_path '../*.rb', __FILE__].each do |file|
  require file
end

module OpenFlow
  module Protocol
    class Parser
      def self.read(io)
        io = StringIO.new(io) if io.is_a?(String)

        header = io.readpartial(Message::HEADER_LENGTH)

        type       = Message::TYPES[header[1].unpack('C')[0].to_i]
        klass_name = type.to_s.split('_').map(&:capitalize).join
        klass      = OpenFlow::Protocol.const_get(klass_name)
        length     = header[2..3].unpack('S>')[0].to_i

        body = io.readpartial(length - Message::HEADER_LENGTH)

        klass.read(header + body)
      end
    end
  end
end
