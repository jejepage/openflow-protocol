require 'spec_helper'

describe OFStatisticsReply do
  context 'with description' do
    let(:desc) {
      'Manufacturer description'.pad(256) +
      'Hardware description'.pad(256) +
      'Software description'.pad(256) +
      '123456789'.pad(32) +
      'Datapath description'.pad(256)
    }
    let(:data) {
      [
        1, 17, 0x04, 0x2c, 0, 0, 0, 1, # header
        0, 0,                          # statistic_type
        0, 1,                          # flags
      ].pack('C*') + desc
    }

    it 'should read binary' do
      msg = OFStatisticsReply.read(data)
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(1068)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:description)
      expect(msg.flags).to eq([:reply_more])
      expect(msg.statistics.serial_number).to eq('123456789')
    end
    it 'should be parsable' do
      msg = OFParser.read(data)
      expect(msg.class).to eq(OFStatisticsReply)
    end
    it 'should initialize with default values' do
      msg = OFStatisticsReply.new
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(1068)
      expect(msg.xid).to eq(0)
      expect(msg.statistic_type).to eq(:description)
      expect(msg.flags).to be_empty
      expect(msg.statistics.serial_number).to eq('')
    end
    it 'should initialize with some values' do
      msg = OFStatisticsReply.new(
        xid: 1,
        statistic_type: :description,
        flags: [:reply_more],
        statistics: {
          serial_number: '123456789'
        }
      )
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(1068)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:description)
      expect(msg.flags).to eq([:reply_more])
      expect(msg.statistics.serial_number).to eq('123456789')
    end
  end

  context 'with flow' do
    let(:data) {
      [
        1, 17, 0, 108, 0, 0, 0, 1, # header
        0, 1,                      # statistic_type
        0, 1,                      # flags

        # flow_statistics_reply
        0, 96, # len
        1,     # table_id
        0,     # padding

        #   match
        0, 0x30, 0x20, 0x4f, # wildcards
        0, 0,                # in_port
        0, 0, 0, 0, 0, 0,    # mac_source
        0, 0, 0, 0, 0, 0,    # mac_destination
        0xff, 0xff,          # vlan_id
        0,                   # vlan_pcp
        0,                   # padding
        8, 0,                # mac_protocol
        0,                   # ip_tos
        6,                   # ip_protocol
        0, 0,                # padding
        0, 0, 0, 0,          # ip_source
        192, 168, 0, 2,      # ip_destination
        0, 0,                # source_port
        0x0b, 0xb8,          # destination_port

        0, 0, 0, 50,             # duration_seconds
        0, 0, 0, 10,             # duration_nanoseconds
        0x0b, 0xb8,              # priority
        0, 100,                  # idle_timeout
        1, 0x2c,                 # hard_timeout
        0, 0, 0, 0, 0, 0,        # padding
        0, 0, 0, 0, 0, 0, 0, 1,  # cookie
        0, 0, 0, 0, 0, 0, 0, 10, # packet_count
        0, 0, 0, 0, 0, 0, 0, 80, # byte_count

        #   actions
        #     output
        0, 0, 0, 8, # header
        0, 1,       # port
        0xff, 0xff # max_length
      ].pack('C*')
    }

    it 'should read binary' do
      msg = OFStatisticsReply.read(data)
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(108)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:flow)
      expect(msg.flags).to eq([:reply_more])
      expect(msg.statistics.table_id).to eq(1)
      expect(msg.statistics.actions.length).to eq(1)
    end
    it 'should be parsable' do
      msg = OFParser.read(data)
      expect(msg.class).to eq(OFStatisticsReply)
    end
    it 'should initialize with default values' do
      msg = OFStatisticsReply.new(statistic_type: :flow)
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(100)
      expect(msg.xid).to eq(0)
      expect(msg.statistic_type).to eq(:flow)
      expect(msg.flags).to be_empty
      expect(msg.statistics.table_id).to eq(:all)
      expect(msg.statistics.actions).to be_empty
    end
    it 'should initialize with some values' do
      msg = OFStatisticsReply.new(
        xid: 1,
        statistic_type: :flow,
        flags: [:reply_more],
        statistics: {
          table_id: 1,
          actions: [OFActionOutput.new(port: 1)]
        }
      )
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(108)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:flow)
      expect(msg.flags).to eq([:reply_more])
      expect(msg.statistics.table_id).to eq(1)
      expect(msg.statistics.actions.length).to eq(1)
    end
  end

  context 'with aggregate' do
    let(:data) {
      [
        1, 17, 0, 36, 0, 0, 0, 1, # header
        0, 2,                     # statistic_type
        0, 1,                     # flags

        # aggregate_statistics_reply
        0, 0, 0, 0, 0, 0, 0, 10, # packet_count
        0, 0, 0, 0, 0, 0, 0, 80, # byte_count
        0, 0, 0, 4,              # flow_count
        0, 0, 0, 0               # padding
      ].pack('C*')
    }

    it 'should read binary' do
      msg = OFStatisticsReply.read(data)
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(36)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:aggregate)
      expect(msg.flags).to eq([:reply_more])
      expect(msg.statistics.packet_count).to eq(10)
    end
    it 'should initialize with default values' do
      msg = OFStatisticsReply.new(statistic_type: :aggregate)
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(36)
      expect(msg.xid).to eq(0)
      expect(msg.statistic_type).to eq(:aggregate)
      expect(msg.flags).to be_empty
      expect(msg.statistics.packet_count).to eq(0)
    end
    it 'should be parsable' do
      msg = OFParser.read(data)
      expect(msg.class).to eq(OFStatisticsReply)
    end
    it 'should initialize with some values' do
      msg = OFStatisticsReply.new(
        xid: 1,
        statistic_type: :aggregate,
        flags: [:reply_more],
        statistics: {
          packet_count: 10,
          byte_count: 80,
          flow_count: 4
        }
      )
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(36)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:aggregate)
      expect(msg.flags).to eq([:reply_more])
      expect(msg.statistics.packet_count).to eq(10)
    end
  end

  context 'with table' do
    let(:data) {
      [
        1, 17, 0, 76, 0, 0, 0, 1, # header
        0, 3,                     # statistic_type
        0, 1,                     # flags

        # array of table_statistics
        1,                                # table_id
        0, 0, 0,                          # padding
        116, 97, 98, 108, 101, 45, 49, 0, # name
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 8, 0x20, 1,                    # wildcards
        0, 0, 0, 10,                      # max_entries
        0, 0, 0, 5,                       # active_count
        0, 0, 0, 0, 0, 0, 0, 4,           # lookup_count
        0, 0, 0, 0, 0, 0, 0, 1            # matched_count
      ].pack('C*')
    }

    it 'should read binary' do
      msg = OFStatisticsReply.read(data)
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(76)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:table)
      expect(msg.flags).to eq([:reply_more])
      expect(msg.statistics.length).to eq(1)
      expect(msg.statistics.first.table_id).to eq(1)
    end
    it 'should be parsable' do
      msg = OFParser.read(data)
      expect(msg.class).to eq(OFStatisticsReply)
    end
    it 'should initialize with default values' do
      msg = OFStatisticsReply.new(statistic_type: :table)
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(12)
      expect(msg.xid).to eq(0)
      expect(msg.statistic_type).to eq(:table)
      expect(msg.flags).to be_empty
      expect(msg.statistics).to be_empty
    end
    it 'should initialize with some values' do
      msg = OFStatisticsReply.new(
        xid: 1,
        statistic_type: :table,
        flags: [:reply_more],
        statistics: [{table_id: 1}]
      )
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(76)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:table)
      expect(msg.flags).to eq([:reply_more])
      expect(msg.statistics.length).to eq(1)
      expect(msg.statistics.first.table_id).to eq(1)
    end
  end

  context 'with port' do
    let(:data) {
      [
        1, 17, 0, 116, 0, 0, 0, 1, # header
        0, 4,                      # statistic_type
        0, 1,                      # flags

        # array of port_statistics_reply
        0, 1,                    # port_number
        0, 0, 0, 0, 0, 0,        # padding
        0, 0, 0, 0, 0, 0, 0, 10, # receive_packets
        0, 0, 0, 0, 0, 0, 0, 10, # transmit_packets
        0, 0, 0, 0, 0, 0, 0, 80, # receive_bytes
        0, 0, 0, 0, 0, 0, 0, 80, # transmit_bytes
        0, 0, 0, 0, 0, 0, 0, 5,  # receive_dropped
        0, 0, 0, 0, 0, 0, 0, 5,  # transmit_dropped
        0, 0, 0, 0, 0, 0, 0, 2,  # receive_errors
        0, 0, 0, 0, 0, 0, 0, 2,  # transmit_errors
        0, 0, 0, 0, 0, 0, 0, 1,  # receive_frame_errors
        0, 0, 0, 0, 0, 0, 0, 0,  # receive_overrun_errors
        0, 0, 0, 0, 0, 0, 0, 1,  # receive_crc_errors
        0, 0, 0, 0, 0, 0, 0, 3   # collisions
      ].pack('C*')
    }

    it 'should read binary' do
      msg = OFStatisticsReply.read(data)
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(116)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:port)
      expect(msg.flags).to eq([:reply_more])
      expect(msg.statistics.length).to eq(1)
      expect(msg.statistics.first.port_number).to eq(1)
    end
    it 'should be parsable' do
      msg = OFParser.read(data)
      expect(msg.class).to eq(OFStatisticsReply)
    end
    it 'should initialize with default values' do
      msg = OFStatisticsReply.new(statistic_type: :port)
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(12)
      expect(msg.xid).to eq(0)
      expect(msg.statistic_type).to eq(:port)
      expect(msg.flags).to be_empty
      expect(msg.statistics).to be_empty
    end
    it 'should initialize with some values' do
      msg = OFStatisticsReply.new(
        xid: 1,
        statistic_type: :port,
        flags: [:reply_more],
        statistics: [{port_number: 1}]
      )
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(116)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:port)
      expect(msg.flags).to eq([:reply_more])
      expect(msg.statistics.length).to eq(1)
      expect(msg.statistics.first.port_number).to eq(1)
    end
  end

  context 'with queue' do
    let(:data) {
      [
        1, 17, 0, 44, 0, 0, 0, 1, # header
        0, 5,                     # statistic_type
        0, 1,                     # flags

        # array of queue_statistics_reply
        0, 1,                    # port_number
        0, 0,                    # padding
        0, 0, 0, 1,              # queue_id
        0, 0, 0, 0, 0, 0, 0, 80, # transmit_bytes
        0, 0, 0, 0, 0, 0, 0, 10, # transmit_packets
        0, 0, 0, 0, 0, 0, 0, 2   # transmit_errors
      ].pack('C*')
    }

    it 'should read binary' do
      msg = OFStatisticsReply.read(data)
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(44)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:queue)
      expect(msg.flags).to eq([:reply_more])
      expect(msg.statistics.length).to eq(1)
      expect(msg.statistics.first.port_number).to eq(1)
    end
    it 'should be parsable' do
      msg = OFParser.read(data)
      expect(msg.class).to eq(OFStatisticsReply)
    end
    it 'should initialize with default values' do
      msg = OFStatisticsReply.new(statistic_type: :queue)
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(12)
      expect(msg.xid).to eq(0)
      expect(msg.statistic_type).to eq(:queue)
      expect(msg.flags).to be_empty
      expect(msg.statistics).to be_empty
    end
    it 'should initialize with some values' do
      msg = OFStatisticsReply.new(
        xid: 1,
        statistic_type: :queue,
        flags: [:reply_more],
        statistics: [{port_number: 1}]
      )
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(44)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:queue)
      expect(msg.flags).to eq([:reply_more])
      expect(msg.statistics.length).to eq(1)
      expect(msg.statistics.first.port_number).to eq(1)
    end
  end

  context 'with vendor' do
    let(:data) {
      [
        1, 17, 0, 20, 0, 0, 0, 1, # header
        0xff, 0xff,               # statistic_type
        0, 0,                     # flags

        # vendor_statistics
        0, 0, 0, 1, # vendor
        1, 2, 3, 4  # body
      ].pack('C*')
    }

    it 'should read binary' do
      msg = OFStatisticsReply.read(data)
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(20)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:vendor)
      expect(msg.flags).to be_empty
      expect(msg.statistics.vendor).to eq(1)
      expect(msg.statistics.body).to eq([1, 2, 3, 4].pack('C*'))
    end
    it 'should be parsable' do
      msg = OFParser.read(data)
      expect(msg.class).to eq(OFStatisticsReply)
    end
    it 'should initialize with default values' do
      msg = OFStatisticsReply.new(statistic_type: :vendor)
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(16)
      expect(msg.xid).to eq(0)
      expect(msg.statistic_type).to eq(:vendor)
      expect(msg.flags).to be_empty
      expect(msg.statistics.vendor).to eq(0)
      expect(msg.statistics.body).to be_empty
    end
    it 'should initialize with some values' do
      msg = OFStatisticsReply.new(
        xid: 1,
        statistic_type: :vendor,
        statistics: {
          vendor: 1,
          body: [1, 2, 3, 4].pack('C*')
        }
      )
      expect(msg.version).to eq(OFMessage::OFP_VERSION)
      expect(msg.type).to eq(:statistics_reply)
      expect(msg.len).to eq(20)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:vendor)
      expect(msg.flags).to be_empty
      expect(msg.statistics.vendor).to eq(1)
      expect(msg.statistics.body).to eq([1, 2, 3, 4].pack('C*'))
    end
  end
end
