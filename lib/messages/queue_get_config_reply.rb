require_relative 'message'

class OFQueueGetConfigReply < OFMessage
  of_port_number_strict :port
  uint48 :padding
  hide :padding
  array :queues,
    type: :of_packet_queue,
    read_until: :eof

  def body_length
    8 + queues.to_binary_s.length
  end
end
