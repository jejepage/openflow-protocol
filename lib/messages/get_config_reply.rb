require_relative 'message'

class OFGetConfigReply < OFMessage
  FLAGS = [:fragments_normal, :fragments_drop, :fragments_reassemble]

  enum16 :flags, list: FLAGS
  uint16 :miss_send_length, initial_value: 0

  def body_length
    4
  end
end
