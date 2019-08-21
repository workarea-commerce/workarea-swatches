$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'workarea/swatches/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'workarea-swatches'
  s.version     = Workarea::Swatches::VERSION
  s.authors     = ['Ben Crouse']
  s.email       = ['bcrouse@weblinc.com']
  s.homepage    = 'https://github.com/workarea-commerce/workarea-swatches'
  s.summary     = 'Adds swatching to the Workarea platform'
  s.description = 'Provides global and custom swatches for products'

  s.files = `git ls-files`.split("\n")

  s.license = 'Business Software License'
end
