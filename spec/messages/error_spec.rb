require 'spec_helper'

describe OFError do
  it 'should read binary' do
    msg = OFError.read [
      1, 1, 0, 16, 0, 0, 0, 1, # header
      0, 0,                    # type
      0, 0,                    # code
      1, 2, 3, 4               # data
    ].pack('C*')
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:error)
    expect(msg.len).to eq(16)
    expect(msg.xid).to eq(1)
    expect(msg.error_type).to eq(:hello_failed)
    expect(msg.error_code).to eq(:incompatible)
    expect(msg.data).to eq([1, 2, 3, 4].pack('C*'))
  end
  it 'should read binary' do
    msg = OFError.read [
      1, 1, 0, 12, 0, 0, 0, 1, # header
      0, 2,                    # type
      0, 4                     # code
    ].pack('C*')
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:error)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(1)
    expect(msg.error_type).to eq(:bad_action)
    expect(msg.error_code).to eq(:bad_out_port)
    expect(msg.data).to be_empty
  end
  it 'should initialize with default values' do
    msg = OFError.new
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:error)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(0)
    expect(msg.error_type).to eq(:hello_failed)
    expect(msg.error_code).to eq(:incompatible)
    expect(msg.data).to be_empty
  end
  it 'should initialize with some values' do
    msg = OFError.new(
      xid: 1,
      error_type: :port_mod_failed,
      error_code: :bad_port
    )
    expect(msg.version).to eq(OFMessage::OFP_VERSION)
    expect(msg.type).to eq(:error)
    expect(msg.len).to eq(12)
    expect(msg.xid).to eq(1)
    expect(msg.error_type).to eq(:port_mod_failed)
    expect(msg.error_code).to eq(:bad_port)
  end
end
