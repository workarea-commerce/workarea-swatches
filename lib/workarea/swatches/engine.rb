module Workarea
  module Swatches
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::Swatches

      config.to_prepare do
        Storefront::ApplicationController.helper(Storefront::SwatchesHelper)
      end
    end
  end
end
