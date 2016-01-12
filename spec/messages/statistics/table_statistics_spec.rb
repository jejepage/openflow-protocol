describe TableStatistics do
  it 'should read binary' do
    stats = TableStatistics.read [
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
    expect(stats.table_id).to eq(1)
    expect(stats.name).to eq('table-1')
    expect(stats.wildcards).to eq([:in_port, :ip_source_all, :ip_destination_all])
    expect(stats.max_entries).to eq(10)
    expect(stats.active_count).to eq(5)
    expect(stats.lookup_count).to eq(4)
    expect(stats.matched_count).to eq(1)
  end
  it 'should initialize with default values' do
    stats = TableStatistics.new
    expect(stats.table_id).to eq(0)
    expect(stats.name).to eq('')
    expect(stats.wildcards).to be_empty
    expect(stats.max_entries).to eq(0)
    expect(stats.active_count).to eq(0)
    expect(stats.lookup_count).to eq(0)
    expect(stats.matched_count).to eq(0)
  end
  it 'should initialize with some values' do
    stats = TableStatistics.new(
      table_id: 1,
      name: 'table-1',
      wildcards: [:in_port, :ip_source_all, :ip_destination_all],
      max_entries: 10,
      active_count: 5,
      lookup_count: 4,
      matched_count: 1
    )
    expect(stats.table_id).to eq(1)
    expect(stats.name).to eq('table-1')
    expect(stats.wildcards).to eq([:in_port, :ip_source_all, :ip_destination_all])
    expect(stats.max_entries).to eq(10)
    expect(stats.active_count).to eq(5)
    expect(stats.lookup_count).to eq(4)
    expect(stats.matched_count).to eq(1)
  end
end
