require 'test_helper'

module Workarea
  module Storefront
    class BrowseSwatchesSystemTest < Workarea::SystemTest
      def test_swatches_on_browse_pages
        create_swatch(name: 'Red', image: product_image_file)
        create_swatch(name: 'Blue', hex: '0000ff')

        product = create_product(
          template: 'swatches',
          variants: [
            {
              sku: 'SKU1',
              details: { color: 'Red', size: 'Small', material: 'Cotton' }
            },
            {
              sku: 'SKU2',
              details: { color: 'Blue', size: 'Small', material: 'Suede' }
            }
          ]
        )

        category = create_category(product_ids: [product.id])

        visit storefront.category_path(category)

        assert_selector('.swatch-options__swatch-button-image--red')
        assert_selector('.swatch-options__swatch-button--blue')

        find('.swatch-options__swatch-button-image--red').click
        wait_for_xhr

        assert_selector(
          '.swatch-options__swatch--selected .swatch-options__swatch-button-image--red'
        )

        find('.swatch-options__swatch-button--blue').click
        wait_for_xhr

        assert_selector(
          '.swatch-options__swatch--selected .swatch-options__swatch-button--blue'
        )

        click_link product.name, match: :first
        assert_current_path(storefront.product_path(product, color: 'Blue'))
      end
    end
  end
end
