require_relative 'action'

class OFActionSetIpTos < OFAction
  uint8 :tos
  uint24 :padding
  hide :padding

  def body_length
    4
  end
end
