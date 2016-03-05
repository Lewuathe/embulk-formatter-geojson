
Gem::Specification.new do |spec|
  spec.name          = "embulk-formatter-geojson"
  spec.version       = "0.1.0"
  spec.authors       = ["lewuathe"]
  spec.summary       = "Geojson formatter plugin for Embulk"
  spec.description   = "Formats Geojson files for other file output plugins."
  spec.email         = ["lewuathe@me.com"]
  spec.licenses      = ["MIT"]
  spec.homepage      = "https://github.com/lewuathe/embulk-formatter-geojson"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  #spec.add_dependency 'YOUR_GEM_DEPENDENCY', ['~> YOUR_GEM_DEPENDENCY_VERSION']
  spec.add_development_dependency 'embulk', ['>= 0.8.6']
  spec.add_development_dependency 'bundler', ['>= 1.10.6']
  spec.add_development_dependency 'rake', ['>= 10.0']
end
