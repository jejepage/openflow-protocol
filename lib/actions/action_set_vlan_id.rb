require_relative 'action'

class OFActionSetVlanId < OFAction
  uint16 :vlan_id, initial_value: 0
  uint16 :padding
  hide :padding

  def body_length
    4
  end
end
