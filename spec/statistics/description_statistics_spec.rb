require 'spec_helper'

describe OFDescriptionStatistics do
  it 'should read binary' do
    stats = OFDescriptionStatistics.read 'Manufacturer description'.pad(256) +
                                         'Hardware description'.pad(256) +
                                         'Software description'.pad(256) +
                                         '123456789'.pad(32) +
                                         'Datapath description'.pad(256)
    expect(stats.manufacturer_description).to eq('Manufacturer description')
    expect(stats.hardware_description).to eq('Hardware description')
    expect(stats.software_description).to eq('Software description')
    expect(stats.serial_number).to eq('123456789')
    expect(stats.datapath_description).to eq('Datapath description')
  end
  it 'should initialize with default values' do
    stats = OFDescriptionStatistics.new
    expect(stats.manufacturer_description).to eq('')
    expect(stats.hardware_description).to eq('')
    expect(stats.software_description).to eq('')
    expect(stats.serial_number).to eq('')
    expect(stats.datapath_description).to eq('')
  end
  it 'should initialize with some values' do
    stats = OFDescriptionStatistics.new(
      manufacturer_description: 'Manufacturer description',
      hardware_description: 'Hardware description',
      software_description: 'Software description',
      serial_number: '123456789',
      datapath_description: 'Datapath description'
    )
    expect(stats.manufacturer_description).to eq('Manufacturer description')
    expect(stats.hardware_description).to eq('Hardware description')
    expect(stats.software_description).to eq('Software description')
    expect(stats.serial_number).to eq('123456789')
    expect(stats.datapath_description).to eq('Datapath description')
  end
end
