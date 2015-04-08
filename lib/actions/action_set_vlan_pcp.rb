require_relative 'action'

class OFActionSetVlanPcp < OFAction
  uint8 :vlan_pcp, initial_value: 0
  uint24 :padding
  hide :padding

  def body_length
    4
  end
end
