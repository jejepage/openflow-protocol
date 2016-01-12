Dir[File.expand_path '../action_*.rb', __FILE__].each do |file|
  require file
end

module OpenFlow
  module Protocol
    class Actions < ArrayOfSubclasses; end
  end
end
