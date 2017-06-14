lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "jekyll-theme-pages"
  spec.version       = "0.1.0"
  spec.authors       = ["Pavel Tsurbeleu"]
  spec.email         = ["pavel.tsurbeleu@me.com"]

  spec.summary       = %q{Pages from a gem-based Jekyll theme}
  spec.description   = %q{A Jekyll plugin, that allows you to use pages defined in a gem-based Jekyll theme.}
  spec.homepage      = "https://github.com/ptsurbeleu/jekyll-theme-pages/"
  spec.license       = "MIT"
  spec.has_rdoc      = false

  spec.files         = %W(Rakefile Gemfile README.md LICENSE) + Dir["lib/**/*"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "jekyll", ">= 3.0", "~> 3.1"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
