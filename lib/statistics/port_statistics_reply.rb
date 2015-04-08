require_relative '../structs/port_number'

class OFPortStatisticsReply < BinData::Record
  endian :big
  of_port_number :port_number, initial_value: 0
  uint48 :padding
  hide :padding
  uint64 :receive_packets, initial_value: 0
  uint64 :transmit_packets, initial_value: 0
  uint64 :receive_bytes, initial_value: 0
  uint64 :transmit_bytes, initial_value: 0
  uint64 :receive_dropped, initial_value: 0
  uint64 :transmit_dropped, initial_value: 0
  uint64 :receive_errors, initial_value: 0
  uint64 :transmit_errors, initial_value: 0
  uint64 :receive_frame_errors, initial_value: 0
  uint64 :receive_overrun_errors, initial_value: 0
  uint64 :receive_crc_errors, initial_value: 0
  uint64 :collisions, initial_value: 0
end
