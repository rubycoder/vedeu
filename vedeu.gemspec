# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'vedeu'
  spec.version       = '0.1.0'
  spec.authors       = ['Gavin Laking']
  spec.email         = ['gavinlaking@gmail.com']
  spec.summary       = %q{A terminal case of wonderland.}
  spec.homepage      = 'https://github.com/gavinlaking/vedeu'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',            '~> 1.6'
  spec.add_development_dependency 'guard',              '2.6.1'
  spec.add_development_dependency 'guard-minitest',     '2.3.1'
  spec.add_development_dependency 'minitest',           '5.4.0'
  spec.add_development_dependency 'minitest-reporters', '1.0.5'
  spec.add_development_dependency 'pry',                '0.10.0'
  spec.add_development_dependency 'rake',               '10.3.2'
  spec.add_development_dependency 'ruby-prof',          '0.15.1'
  spec.add_development_dependency 'simplecov',          '0.9.0'

  spec.add_dependency 'virtus', '1.0.3'
end
