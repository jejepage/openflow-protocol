require_relative 'message'

class OFPortStatus < OFMessage
  REASONS = [:add, :delete, :modify]

  enum8 :reason, list: REASONS
  uint56 :padding
  hide :padding
  of_physical_port :desc

  def body_length
    56
  end
end
