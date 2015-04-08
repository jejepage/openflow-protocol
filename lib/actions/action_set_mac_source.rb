require_relative 'action'

class OFActionSetMacSource < OFAction
  mac_address :mac_address
  uint48 :padding
  hide :padding

  def body_length
    12
  end
end
