require 'bindata'

class OFPortNumberStrict < BinData::Primitive
  endian :big
  uint16 :port_number, initial_value: 0

  def get
    port_number
  end

  def set(value)
    raise ArgumentError, 'Invalid port number.' unless (0..OFPortNumber::MAX).include? value
    self.port_number = value
  end
end

class OFPortNumber < BinData::Primitive
  NUMBERS = {
    in_port: 0xfff8,
    table: 0xfff9,
    normal: 0xfffa,
    flood: 0xfffb,
    all: 0xfffc,
    controller: 0xfffd,
    local: 0xfffe,
    none: 0xffff
  }
  MAX = 0xff00

  endian :big
  uint16 :port_number, initial_value: NUMBERS[:none]

  def get
    NUMBERS.invert.fetch(port_number)
  rescue KeyError
    port_number
  end

  def set(value)
    self.port_number = NUMBERS.fetch(value)
  rescue KeyError
    raise ArgumentError, 'Invalid port number.' unless (0..MAX).include? value
    self.port_number = value
  end
end
