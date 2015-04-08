require_relative 'message'

class OFFlowMod < OFMessage
  of_match :match
  uint64 :cookie, initial_value: 0
  enum16 :command, list: [:add, :modify, :modify_strict, :delete, :delete_strict]
  uint16 :idle_timeout, initial_value: 0
  uint16 :hard_timeout, initial_value: 0
  uint16 :priority, initial_value: 0
  uint32 :buffer_id, initial_value: 0xffffffff
  of_port_number :out_port, initial_value: (lambda do
    /^delete/ =~ command.to_s ? :none : 0
  end)
  flags16 :flags, list: [:send_flow_removed, :check_overlapping, :emergency]
  of_actions :actions, length: -> { len - actions.rel_offset }

  def body_length
    64 + actions.to_binary_s.length
  end
end
