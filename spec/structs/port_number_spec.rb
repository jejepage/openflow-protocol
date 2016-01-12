describe PortNumberStrict do
  it 'should read binary' do
    port_number = PortNumberStrict.read [0, 1].pack('C*')
    expect(port_number).to eq(1)
  end
  it 'should initialize with default values' do
    port_number = PortNumberStrict.new
    expect(port_number).to eq(0)
  end
  it 'should initialize with some values' do
    port_number = PortNumberStrict.new(2)
    expect(port_number).to eq(2)
  end
  it 'should raise an error if greater than max value' do
    expect { PortNumberStrict.new(:none) }.to raise_error(ArgumentError)
    expect { PortNumberStrict.new(0xff01) }.to raise_error(ArgumentError)
  end
end

describe PortNumber do
  it 'should read binary' do
    port_number = PortNumber.read [0, 1].pack('C*')
    expect(port_number).to eq(1)
  end
  it 'should initialize with default values' do
    port_number = PortNumber.new
    expect(port_number).to eq(:none)
  end
  it 'should initialize with some values' do
    port_number = PortNumber.new(:local)
    expect(port_number).to eq(:local)
  end
  it 'should raise an error with invalid port' do
    expect { PortNumber.new(0xff01) }.to raise_error(ArgumentError)
  end
end
