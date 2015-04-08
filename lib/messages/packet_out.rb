require_relative 'message'

class OFPacketOut < OFMessage
  enum32 :buffer_id, list: {none: 0xffffffff}, initial_value: -> { :none }
  of_port_number :in_port
  uint16 :actions_length, value: -> { actions.to_binary_s.length }
  of_actions :actions, length: -> { actions_length }
  string :data, read_length: -> { len - data.rel_offset }

  def body_length
    8 + actions_length + data.length
  end
end
