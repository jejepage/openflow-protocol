require_relative 'message'

class OFPacketIn < OFMessage
  REASONS = [:no_match, :action]

  enum32 :buffer_id, list: {none: 0xffffffff}, initial_value: -> { :none }
  uint16 :total_length, value: -> { data.length }
  of_port_number :in_port
  enum8 :reason, list: REASONS
  uint8 :padding
  hide :padding
  string :data, read_length: :total_length

  def body_length
    10 + data.length
  end
end
