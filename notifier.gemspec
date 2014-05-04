# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "notifier"
  spec.version       = "0.0.1"
  spec.authors       = ["Matt Garriott"]
  spec.email         = ["matt.garriott@gmail.com"]
  spec.summary       = "Easy email notifications in ruby"
  spec.description   = "Easy email notifications with both CLI and ruby library."
  spec.homepage      = "https://github.com/mgarriott/notifier"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
