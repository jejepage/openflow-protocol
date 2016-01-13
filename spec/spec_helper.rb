require 'coveralls'
Coveralls.wear!
require 'openflow-protocol'

include OpenFlow::Protocol

class String
  def pad(length, value = [0].pack('C*'))
    self + value * (length - self.length)
  end
end
