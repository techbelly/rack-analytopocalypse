Gem::Specification.new do |spec|
  spec.name        = 'rack-analytopocalypse'
  spec.version     = '0.0.9'
  spec.authors     = ['Ben Griffiths']
  spec.date        = '2011-08-18'
  spec.summary     = 'Obfuscating Google Analytics for Rack applications'
  spec.description = 'Naive obfuscation for google analytics'
  spec.email       = 'bengriffiths@gmail.com'
  spec.homepage    = 'http://github.com/techbelly/rack-analytopocalypse'

  spec.extra_rdoc_files = [
     "LICENSE",
     "README.rdoc"
  ]
  spec.files = [
     "README.rdoc",
     "lib/rack-analytopocalypse.rb",
     "lib/rack/analytopocalypse.rb"
  ]
  spec.require_paths = %w[lib]

  spec.add_dependency 'rack'
end
