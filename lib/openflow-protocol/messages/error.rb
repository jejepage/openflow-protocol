require 'openflow-protocol/messages/message'

module OpenFlow
  module Protocol
    class Error < Message
      TYPES = [
        :hello_failed,
        :bad_request,
        :bad_action,
        :flow_mod_failed,
        :port_mod_failed,
        :queue_op_failed
      ]
      HELLO_FAILED_CODES = [:incompatible, :eperm]
      BAD_REQUEST_CODES = [
        :bad_version,
        :bad_type,
        :bad_stat,
        :bad_vendor,
        :bad_sub_type,
        :eperm,
        :bad_length,
        :buffer_empty,
        :buffer_unknown
      ]
      BAD_ACTION_CODES = [
        :bad_type,
        :bad_length,
        :bad_vendor,
        :bad_vendor_type,
        :bad_out_port,
        :bad_argument,
        :eperm,
        :too_many,
        :bad_queue
      ]
      FLOW_MOD_FAILED_CODES = [
        :all_tables_full,
        :overlap,
        :eperm,
        :bad_emerg_timeout,
        :bad_command,
        :unsupported
      ]
      PORT_MOD_FAILED_CODES = [:bad_port, :bad_hardware_address]
      QUEUE_OP_FAILED_CODES = [:bad_port, :bad_queue, :eperm]

      enum16 :error_type, list: TYPES
      choice :error_code, selection: -> { error_type.to_s } do
        enum16 'hello_failed',    list: HELLO_FAILED_CODES
        enum16 'bad_request',     list: BAD_REQUEST_CODES
        enum16 'bad_action',      list: BAD_ACTION_CODES
        enum16 'flow_mod_failed', list: FLOW_MOD_FAILED_CODES
        enum16 'port_mod_failed', list: PORT_MOD_FAILED_CODES
        enum16 'queue_op_failed', list: QUEUE_OP_FAILED_CODES
        uint16 :default
      end
      rest :data

      def body_length
        4 + data.length
      end

      def parsed_data
        Parser.read data.to_s
      end
    end
  end
end
