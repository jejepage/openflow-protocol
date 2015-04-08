(Dir[File.expand_path '../helpers/**/*.rb', __dir__] +
 Dir[File.expand_path '../structs/**/*.rb', __dir__] +
 Dir[File.expand_path '../actions/**/*.rb', __dir__] +
 Dir[File.expand_path '../statistics/**/*.rb', __dir__]).each do |file|
  require file
end

# TODO: use OFPT_, OFPP_, OFPQ_, ... in place of Symbols?
#   check: https://github.com/noxrepo/pox/blob/carp/pox/openflow/libopenflow_01.py
#   -> see decorators
#   ruby decorators: https://github.com/fredwu/ruby_decorators

class OFMessage < SuperclassBase
  OFP_VERSION = 0x1
  HEADER_LENGTH = 8
  TYPES = [
    :hello,
    :error, # TODO
    :echo_request,
    :echo_reply,
    :vendor,
    :features_request,
    :features_reply,
    :get_config_request,
    :get_config_reply,
    :set_config,
    :packet_in,
    :flow_removed,
    :port_status,
    :packet_out,
    :flow_mod,
    :port_mod,
    :statistics_request,
    :statistics_reply,
    :barrier_request,
    :barrier_reply,
    :queue_get_config_request, # TODO
    :queue_get_config_reply # TODO
  ]

  uint8 :version, asserted_value: OFP_VERSION
  enum8 :type, list: TYPES, asserted_value: -> { type_str.to_sym }
  uint16 :len, value: -> { HEADER_LENGTH + body_length }
  uint32 :xid, initial_value: 0
end
