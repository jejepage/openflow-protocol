describe OpenFlow::Protocol::StatisticsRequest do
  let(:data) {
    [
      1, 16, 0, 12, 0, 0, 0, 1, # header
      0, 0,                     # statistic_type
      0, 0,                     # flags
    ].pack('C*')
  }

  context 'with description' do
    it 'should read binary' do
      msg = OpenFlow::Protocol::StatisticsRequest.read(data)
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(12)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:description)
      expect(msg.flags).to be_empty
      expect(msg.statistics).to be_empty
    end
    it 'should be parsable' do
      msg = OpenFlow::Protocol::Parser.read(data)
      expect(msg.class).to eq(OpenFlow::Protocol::StatisticsRequest)
    end
    it 'should initialize with default values' do
      msg = OpenFlow::Protocol::StatisticsRequest.new
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(12)
      expect(msg.xid).to eq(0)
      expect(msg.statistic_type).to eq(:description)
      expect(msg.flags).to be_empty
      expect(msg.statistics).to be_empty
    end
    it 'should initialize with some values' do
      msg = OpenFlow::Protocol::StatisticsRequest.new(
        xid: 1,
        statistic_type: :description
      )
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(12)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:description)
      expect(msg.flags).to be_empty
      expect(msg.statistics).to be_empty
    end
  end

  context 'with flow' do
    it 'should read binary' do
      msg = OpenFlow::Protocol::StatisticsRequest.read [
        1, 16, 0, 56, 0, 0, 0, 1, # header
        0, 1,                     # statistic_type
        0, 0,                     # flags

        # flow_statistics_request
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

        1,    # table_id
        0,    # padding
        0, 1  # out_port
      ].pack('C*')
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(56)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:flow)
      expect(msg.flags).to be_empty
      expect(msg.statistics.table_id).to eq(1)
    end
    it 'should initialize with default values' do
      msg = OpenFlow::Protocol::StatisticsRequest.new(statistic_type: :flow)
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(56)
      expect(msg.xid).to eq(0)
      expect(msg.statistic_type).to eq(:flow)
      expect(msg.flags).to be_empty
      expect(msg.statistics.table_id).to eq(:all)
    end
    it 'should initialize with some values' do
      msg = OpenFlow::Protocol::StatisticsRequest.new(
        xid: 1,
        statistic_type: :flow,
        statistics: {
          table_id: 1
        }
      )
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(56)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:flow)
      expect(msg.flags).to be_empty
      expect(msg.statistics.table_id).to eq(1)
    end
  end

  context 'with aggregate' do
    it 'should read binary' do
      msg = OpenFlow::Protocol::StatisticsRequest.read [
        1, 16, 0, 56, 0, 0, 0, 1, # header
        0, 2,                     # statistic_type
        0, 0,                     # flags

        # aggregate_statistics_request
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

        1,    # table_id
        0,    # padding
        0, 1  # out_port
      ].pack('C*')
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(56)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:aggregate)
      expect(msg.flags).to be_empty
      expect(msg.statistics.table_id).to eq(1)
    end
    it 'should initialize with default values' do
      msg = OpenFlow::Protocol::StatisticsRequest.new(statistic_type: :aggregate)
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(56)
      expect(msg.xid).to eq(0)
      expect(msg.statistic_type).to eq(:aggregate)
      expect(msg.flags).to be_empty
      expect(msg.statistics.table_id).to eq(:all)
    end
    it 'should initialize with some values' do
      msg = OpenFlow::Protocol::StatisticsRequest.new(
        xid: 1,
        statistic_type: :aggregate,
        statistics: {
          table_id: 1
        }
      )
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(56)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:aggregate)
      expect(msg.flags).to be_empty
      expect(msg.statistics.table_id).to eq(1)
    end
  end

  context 'with table' do
    it 'should read binary' do
      msg = OpenFlow::Protocol::StatisticsRequest.read [
        1, 16, 0, 12, 0, 0, 0, 1, # header
        0, 3,                     # statistic_type
        0, 0,                     # flags
      ].pack('C*')
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(12)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:table)
      expect(msg.flags).to be_empty
      expect(msg.statistics).to be_empty
    end
    it 'should initialize with default values' do
      msg = OpenFlow::Protocol::StatisticsRequest.new(statistic_type: :table)
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(12)
      expect(msg.xid).to eq(0)
      expect(msg.statistic_type).to eq(:table)
      expect(msg.flags).to be_empty
      expect(msg.statistics).to be_empty
    end
    it 'should initialize with some values' do
      msg = OpenFlow::Protocol::StatisticsRequest.new(
        xid: 1,
        statistic_type: :table
      )
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(12)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:table)
      expect(msg.flags).to be_empty
      expect(msg.statistics).to be_empty
    end
  end

  context 'with port' do
    it 'should read binary' do
      msg = OpenFlow::Protocol::StatisticsRequest.read [
        1, 16, 0, 20, 0, 0, 0, 1, # header
        0, 4,                     # statistic_type
        0, 0,                     # flags

        # port_statistics_request
        0, 1,            # port_number
        0, 0, 0, 0, 0, 0 # padding
      ].pack('C*')
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(20)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:port)
      expect(msg.flags).to be_empty
      expect(msg.statistics.port_number).to eq(1)
    end
    it 'should initialize with default values' do
      msg = OpenFlow::Protocol::StatisticsRequest.new(statistic_type: :port)
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(20)
      expect(msg.xid).to eq(0)
      expect(msg.statistic_type).to eq(:port)
      expect(msg.flags).to be_empty
      expect(msg.statistics.port_number).to eq(:none)
    end
    it 'should initialize with some values' do
      msg = OpenFlow::Protocol::StatisticsRequest.new(
        xid: 1,
        statistic_type: :port,
        statistics: {port_number: 1}
      )
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(20)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:port)
      expect(msg.flags).to be_empty
      expect(msg.statistics.port_number).to eq(1)
    end
  end

  context 'with queue' do
    it 'should read binary' do
      msg = OpenFlow::Protocol::StatisticsRequest.read [
        1, 16, 0, 20, 0, 0, 0, 1, # header
        0, 5,                     # statistic_type
        0, 0,                     # flags

        # queue_statistics_request
        0, 1,      # port_number
        0, 0,      # padding
        0, 0, 0, 1 # queue_id
      ].pack('C*')
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(20)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:queue)
      expect(msg.flags).to be_empty
      expect(msg.statistics.port_number).to eq(1)
    end
    it 'should initialize with default values' do
      msg = OpenFlow::Protocol::StatisticsRequest.new(statistic_type: :queue)
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(20)
      expect(msg.xid).to eq(0)
      expect(msg.statistic_type).to eq(:queue)
      expect(msg.flags).to be_empty
      expect(msg.statistics.port_number).to eq(:all)
    end
    it 'should initialize with some values' do
      msg = OpenFlow::Protocol::StatisticsRequest.new(
        xid: 1,
        statistic_type: :queue,
        statistics: {port_number: 1}
      )
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(20)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:queue)
      expect(msg.flags).to be_empty
      expect(msg.statistics.port_number).to eq(1)
    end
  end

  context 'with vendor' do
    it 'should read binary' do
      msg = OpenFlow::Protocol::StatisticsRequest.read [
        1, 16, 0, 20, 0, 0, 0, 1, # header
        0xff, 0xff,               # statistic_type
        0, 0,                     # flags

        # vendor_statistics
        0, 0, 0, 1, # vendor
        1, 2, 3, 4  # body
      ].pack('C*')
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(20)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:vendor)
      expect(msg.flags).to be_empty
      expect(msg.statistics.vendor).to eq(1)
      expect(msg.statistics.body).to eq([1, 2, 3, 4].pack('C*'))
    end
    it 'should initialize with default values' do
      msg = OpenFlow::Protocol::StatisticsRequest.new(statistic_type: :vendor)
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(16)
      expect(msg.xid).to eq(0)
      expect(msg.statistic_type).to eq(:vendor)
      expect(msg.flags).to be_empty
      expect(msg.statistics.vendor).to eq(0)
      expect(msg.statistics.body).to be_empty
    end
    it 'should initialize with some values' do
      msg = OpenFlow::Protocol::StatisticsRequest.new(
        xid: 1,
        statistic_type: :vendor,
        statistics: {
          vendor: 1,
          body: [1, 2, 3, 4].pack('C*')
        }
      )
      expect(msg.version).to eq(OpenFlow::Protocol::Message::OFP_VERSION)
      expect(msg.type).to eq(:statistics_request)
      expect(msg.len).to eq(20)
      expect(msg.xid).to eq(1)
      expect(msg.statistic_type).to eq(:vendor)
      expect(msg.flags).to be_empty
      expect(msg.statistics.vendor).to eq(1)
      expect(msg.statistics.body).to eq([1, 2, 3, 4].pack('C*'))
    end
  end
end
