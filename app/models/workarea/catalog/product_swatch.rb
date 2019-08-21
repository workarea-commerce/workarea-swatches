module Workarea
  module Catalog
    class ProductSwatch < Swatch
      embedded_in :product,
        class_name: 'Workarea::Catalog::Product',
        inverse_of: :swatches,
        touch: true
    end
  end
end
