require 'workarea/testing/teaspoon'

Teaspoon.configure do |config|
  config.root = Workarea::Swatches::Engine.root
  Workarea::Teaspoon.apply(config)
end
