require 'openflow-protocol/structs/match'

module OpenFlow
  module Protocol
    class TableStatistics < BinData::Record
      TABLE_IDS = {emergency: 0xfe, all: 0xff}

      endian :big
      enum8 :table_id, list: TABLE_IDS, initial_value: 0
      uint24 :padding
      hide :padding
      string :name, length: 32, trim_padding: true, initial_value: ''
      flags32 :wildcards, list: Match::Wildcards::FLAGS
      uint32 :max_entries, initial_value: 0
      uint32 :active_count, initial_value: 0
      uint64 :lookup_count, initial_value: 0
      uint64 :matched_count, initial_value: 0
    end
  end
end
