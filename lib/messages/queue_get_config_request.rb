require_relative 'message'

class OFQueueGetConfigRequest < OFMessage
  of_port_number_strict :port
  uint16 :padding
  hide :padding

  def body_length
    4
  end
end
