# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_form_autocomplete/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_form_autocomplete'
  spec.version       = SimpleFormAutocomplete::VERSION
  spec.authors       = ['Matt Huggins']
  spec.email         = ['matt.huggins@gmail.com']
  spec.description   = %q{jQuery autocomplete for SimpleForm form fields}
  spec.summary       = %q{jQuery autocomplete for SimpleForm form fields}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'simple_form'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
