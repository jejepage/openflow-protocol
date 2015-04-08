require_relative 'action'

class OFActionSetIpSource < OFAction
  ip_address :ip_address

  def body_length
    4
  end
end
