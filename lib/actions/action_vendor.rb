require_relative 'action'

class OFActionVendor < OFAction
  uint32 :vendor, initial_value: 0

  def body_length
    4
  end
end
