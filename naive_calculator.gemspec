lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'naive_calculator/version'

Gem::Specification.new do |spec|
  spec.name          = 'naive_calculator'
  spec.version       = NaiveCalculator::VERSION
  spec.authors       = ['Svetlin Simonyan']
  spec.email         = ['svetlin.s@gmail.com']

  spec.summary       = 'Calculator'
  spec.description   = 'A calculator supporting mathematical expressions,' \
                       'variables, functions and rudimentary plotting)'
  spec.homepage      = 'https://github.com/svetlins/naive_calculator'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] =
      'https://github.com/svetlins/naive_calculator'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`
      .split("\x0")
      .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = 'naive_calculator'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_runtime_dependency 'activesupport', '~> 5.2'
  spec.add_runtime_dependency 'treetop', '~> 1.6'
end
