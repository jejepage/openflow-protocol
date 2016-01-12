Dir[File.expand_path 'queue_property_*.rb', __dir__].each do |file|
  require file
end

class OFQueueProperties < ArrayOfSubclasses; end
