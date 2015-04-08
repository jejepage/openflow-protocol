require 'spec_helper'

describe OFPortNumber do
  it 'should read binary' do
    port_number = OFPortNumber.read [0, 1].pack('C*')
    expect(port_number).to eq(1)
  end
  it 'should initialize with default values' do
    port_number = OFPortNumber.new
    expect(port_number).to eq(:none)
  end
  it 'should initialize with some values' do
    port_number = OFPortNumber.new(:local)
    expect(port_number).to eq(:local)
  end
  it 'should raise an error with invalid port' do
    expect { OFPortNumber.new(0xff01) }.to raise_error(ArgumentError)
  end
end
