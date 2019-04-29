lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "naive_calculator/version"

Gem::Specification.new do |spec|
  spec.name          = "naive_calculator"
  spec.version       = NaiveCalculator::VERSION
  spec.authors       = ["Svetlin Simonyan"]
  spec.email         = ["svetlin.s@gmail.com"]

  spec.summary       = %q{Calculator}
  spec.description   = %q{A calculator supporting mathematical expressions, variables, functions and rudimentary plotting}
  spec.homepage      = "https://github.com/svetlins/naive_calculator"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'http://rubygems.org'

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/svetlins/naive_calculator"
    spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = 'naive_calculator'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency 'treetop'
  spec.add_runtime_dependency 'pry'
  spec.add_runtime_dependency 'activesupport'
end
