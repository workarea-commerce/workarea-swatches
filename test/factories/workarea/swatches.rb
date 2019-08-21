require 'workarea/testing/factories'

module Workarea
  module Factories
    module Swatches
      def create_swatch(overrides = {})
        attributes = { name: 'Red' }.merge(overrides)
        Workarea::Catalog::Swatch.create!(attributes)
      end
    end
  end
end

Workarea::Factories.add(Workarea::Factories::Swatches)
