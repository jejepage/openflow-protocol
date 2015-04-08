require_relative 'action'

class OFActionEnqueue < OFAction
  of_port_number :port
  uint48 :padding
  hide :padding
  uint32 :queue_id, initial_value: 0

  def body_length
    12
  end
end
