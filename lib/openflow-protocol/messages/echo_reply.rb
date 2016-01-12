require 'openflow-protocol/messages/echo_request'

module OpenFlow
  module Protocol
    class EchoReply < EchoRequest; end

    class EchoRequest
      def to_reply
        EchoReply.new(xid: xid, data: data.dup)
      end
    end
  end
end
