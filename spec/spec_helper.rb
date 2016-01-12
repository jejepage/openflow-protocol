require 'openflow-protocol'
require 'coveralls'
Coveralls.wear!

include OpenFlow::Protocol

class String
  def pad(length, value = [0].pack('C*'))
    self + value * (length - self.length)
  end
end
