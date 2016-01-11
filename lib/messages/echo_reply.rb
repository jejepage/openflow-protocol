require_relative 'echo_request'

class OFEchoReply < OFEchoRequest; end

class OFEchoRequest
  def to_reply
    OFEchoReply.new(xid: xid, data: data.dup)
  end
end
