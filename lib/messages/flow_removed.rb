require_relative 'message'

class OFFlowRemoved < OFMessage
  REASONS = [:idle_timeout, :hard_timeout, :delete]

  of_match :match
  uint64 :cookie, initial_value: 0
  uint16 :priority, initial_value: 0
  enum8 :reason, list: REASONS
  uint8 :padding
  hide :padding
  uint32 :duration_seconds, initial_value: 0
  uint32 :duration_nanoseconds, initial_value: 0
  uint16 :idle_timeout, initial_value: 0
  uint16 :padding2
  hide :padding2
  uint64 :packet_count, initial_value: 0
  uint64 :byte_count, initial_value: 0

  def body_length
    80
  end
end
