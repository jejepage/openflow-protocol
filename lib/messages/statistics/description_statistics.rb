require 'bindata'

class OFDescriptionStatistics < BinData::Record
  DESCRIPTION_LENGTH = 256
  SERIAL_NUMBER_LENGTH = 32

  endian :big
  string :manufacturer_description,
         length: DESCRIPTION_LENGTH,
         trim_padding: true,
         initial_value: ''
  string :hardware_description,
         length: DESCRIPTION_LENGTH,
         trim_padding: true,
         initial_value: ''
  string :software_description,
         length: DESCRIPTION_LENGTH,
         trim_padding: true,
         initial_value: ''
  string :serial_number,
         length: SERIAL_NUMBER_LENGTH,
         trim_padding: true,
         initial_value: ''
  string :datapath_description,
         length: DESCRIPTION_LENGTH,
         trim_padding: true,
         initial_value: ''
end
