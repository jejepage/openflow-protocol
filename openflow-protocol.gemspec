$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'openflow-protocol/version'

Gem::Specification.new do |s|
  s.name         = 'openflow-protocol'
  s.version      = OpenFlow::Protocol::VERSION
  s.authors      = ['Jérémy Pagé']
  s.email        = ['contact@jeremypage.me']

  s.summary      = 'OpenFlow Protocol'
  s.description  = 'An OpenFlow Parser/Serializer.'

  s.files        = `git ls-files lib`.split("\n")
  s.test_files   = `git ls-files spec`.split("\n")
  s.require_path = 'lib'

  s.homepage     = 'https://github.com/jejepage/openflow-protocol'
  s.license      = 'MIT'

  s.add_runtime_dependency 'packet-protocols', '0.1.3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 3.2'
  s.add_development_dependency 'coveralls'
end
