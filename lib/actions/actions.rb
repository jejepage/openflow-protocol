Dir[File.expand_path 'action_*.rb', __dir__].each do |file|
  require file
end

class OFActions < ArrayOfSubclasses; end
