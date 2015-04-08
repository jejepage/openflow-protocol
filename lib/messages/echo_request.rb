require_relative 'message'

class OFEchoRequest < OFMessage
  rest :data

  def body_length
    data.length
  end
end
