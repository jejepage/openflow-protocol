require 'spec_helper'

describe OFPortNumberStrict do
  it 'should read binary' do
    port_number = OFPortNumberStrict.read [0, 1].pack('C*')
    expect(port_number).to eq(1)
  end
  it 'should initialize with default values' do
    port_number = OFPortNumberStrict.new
    expect(port_number).to eq(0)
  end
  it 'should initialize with some values' do
    port_number = OFPortNumberStrict.new(2)
    expect(port_number).to eq(2)
  end
  it 'should raise an error if greater than max value' do
    expect { OFPortNumberStrict.new(:none) }.to raise_error(ArgumentError)
    expect { OFPortNumberStrict.new(0xff01) }.to raise_error(ArgumentError)
  end
end

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
