require_relative 'message'

class OFVendor < OFMessage
  uint32 :vendor, initial_value: 0
  rest :data

  def body_length
    4 + data.length
  end
end
