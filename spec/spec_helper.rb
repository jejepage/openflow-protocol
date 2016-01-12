require 'openflow-protocol'

class String
  def pad(length, value = [0].pack('C*'))
    self + value * (length - self.length)
  end
end
