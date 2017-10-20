Gem::Specification.new do |s|
  s.name        = 'stackdo'
  s.version     = '0.0.4'
  s.licenses    = ['MIT']
  s.summary     = "Advanced call stack retrieval"
  s.description = <<END
A library for getting detailed stacktraces (with variables).
END
  s.authors     = ["Dylan McKay"]
  s.email       = 'me@dylanmckay.io'
  s.files       = ["lib/stackdo.rb"]
  s.homepage    = 'https://github.com/dylanmckay/stackdo'

  s.add_runtime_dependency 'binding_of_caller', '~> 0.7.2', '>= 0.7.2'
end

