require 'test_helper'

module Workarea
  module Storefront
    class SwatchesIntegrationTest < Workarea::IntegrationTest
      setup :set_products
      setup :set_swatches

      def set_products
        @products = [
          create_product(
            name: 'Test Product 1',
            filters: { 'Color' => %w(Red Blue) }
          ),
          create_product(
            name: 'Test Product 2',
            filters: { 'Color' => %w(Red Green) }
          )
        ]
      end

      def set_swatches
        create_swatch(name: 'Red', hex: 'ff0000')
        create_swatch(name: 'Blue', hex: '0000ff')
        create_swatch(name: 'Green', image: product_image_file)

        Search::Settings.current.update_attributes!(swatch_facets: ['Color'])
      end

      def test_showing_swatch_filters_on_search
        get storefront.search_path(q: 'test')
        assert_select('.swatch-facet--red', 2)
        assert_select('.swatch-facet--blue', 2)
        assert_select('.swatch-facet--green', 2)
        assert_includes(response.body, '#ff0000')
        assert_includes(response.body, '#0000ff')

        get storefront.search_path(q: 'test', color: ['Red'])
        assert_select('.swatch-facet--red', 2)
        assert_select('.swatch-facet--blue', 2)
        assert_select('.swatch-facet--green', 2)
        assert_includes(response.body, '#ff0000')
        assert_includes(response.body, '#0000ff')

        get storefront.search_path(q: 'test', color: ['Blue'])
        assert_select('.swatch-facet--red', 2)
        assert_select('.swatch-facet--blue', 2)
        assert_select('.swatch-facet--green', 2)
        assert_includes(response.body, '#ff0000')
        assert_includes(response.body, '#0000ff')
      end

      def test_showing_product_with_no_swatches_present_on_browse_pages
        product = create_product(
          template: 'swatches',
          variants: [
            {
              sku: 'SKU1',
              details: { size: 'Small' }
            },
          ]
        )

        category = create_category(product_ids: [product.id])

        get storefront.category_path(category)

        assert_includes(response.body, 'Test Product')
      end
    end
  end
end
