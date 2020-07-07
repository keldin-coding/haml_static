# frozen_string_literal: true

require_relative 'lib/haml_static/version'

Gem::Specification.new do |spec|
  spec.name          = 'haml_static'
  spec.version       = HamlStatic::VERSION
  spec.authors       = ['Jonathon Anderson']
  spec.email         = ['anderson.jonathon.p@gmail.com']

  spec.summary       = 'Used to generate static sites from HAML and Ruby scripts'
  spec.description   = 'Used to generate static sites from HAML and Ruby scripts'
  spec.homepage      = 'https://github.com/lirossarvet/haml_static'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/lirossarvet/haml_static'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rubocop', '~> 0.87.0'
  spec.add_runtime_dependency 'haml', '~> 5.1'
  spec.add_runtime_dependency 'thor', '~> 1.0'
end
