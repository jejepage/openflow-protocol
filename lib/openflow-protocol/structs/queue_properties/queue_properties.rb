Dir[File.expand_path '../queue_property_*.rb', __FILE__].each do |file|
  require file
end

module OpenFlow
  module Protocol
    class QueueProperties < ArrayOfSubclasses; end
  end
end
