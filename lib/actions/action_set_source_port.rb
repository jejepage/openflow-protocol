require_relative 'action'

class OFActionSetSourcePort < OFAction
  uint16 :port, initial_value: 0
  uint16 :padding
  hide :padding

  def body_length
    4
  end
end
