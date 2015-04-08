require_relative 'message'

class OFPortMod < OFMessage
  of_port_number :port_number
  mac_address :hardware_address
  flags32 :config, list: OFPhysicalPort::CONFIG
  flags32 :mask, list: OFPhysicalPort::CONFIG
  flags32 :advertise, list: OFPhysicalPort::FEATURES

  def body_length
    24
  end
end
