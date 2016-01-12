require 'bindata'
require 'bindata-contrib'

class SuperclassBase < BinData::Record
  attr_reader :type_str

  endian :big

  def initialize_instance
    super
    if self.class.name[2..7] == 'Action'
      name = self.class.name[8..-1]
    elsif self.class.name[2..14] == 'QueueProperty'
      name = self.class.name[15..-1]
    else
      name = self.class.name[2..-1]
    end
    @type_str = name.gsub(/([A-Z])/, '_\1')[1..-1].downcase
  end

  def body_length
    0
  end
end
