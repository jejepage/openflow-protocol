require_relative 'action'

class OFActionOutput < OFAction
  of_port_number :port
  uint16 :max_length, initial_value: 0xffff

  def body_length
    4
  end
end
