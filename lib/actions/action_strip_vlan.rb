require_relative 'action'

class OFActionStripVlan < OFAction
  uint32 :padding
  hide :padding

  def body_length
    4
  end
end
