require 'test_helper'

module Workarea
  module Storefront
    module ProductTemplates
      class SwatchesViewModelTest < TestCase
        def test_groups_images_by_options
          product = create_product(
            images: [
              { image: product_image_file, option: 'blue' },
              { image: product_image_file, option: 'red' },
              { image: product_image_file, option: 'Blue' },
              { image: product_image_file, option: nil }
            ]
         )

         view_model = SwatchesViewModel.wrap(product)
         assert_equal(2, view_model.images_by_option.size)
         assert_equal(2, view_model.images_by_option['blue'].size)
         assert_equal(1, view_model.images_by_option['red'].size)
        end

        def test_swatches_by_options
          product = create_product(swatches: [{ name: 'Blue' }, { name: 'Red' }])
          blue = create_swatch(name: 'Blue')
          green = create_swatch(name: 'Green')

          view_model = SwatchesViewModel.wrap(product)
          assert_equal(3, view_model.swatches_by_option.size)
          assert_equal(green, view_model.swatches_by_option['green'])
          assert_equal(
            product.swatches.find('blue'),
            view_model.swatches_by_option['blue']
          )
          assert_equal(
            product.swatches.find('red'),
            view_model.swatches_by_option['red']
          )
        end

        def test_browse_link_options
          product = create_product(
            variants: [{ sku: 'SKU', details: { 'Color' => %w(red) } }]
          )

          view_model = SwatchesViewModel.wrap(product, color: 'red')
          assert_equal('red', view_model.browse_link_options['color'])
        end

        def test_browse_swatch_option
          product = create_product(
            variants: [
              { sku: 'SKU', details: { 'Color' => %w(red), 'Size' => %w(large) } },
              { sku: 'SKU', details: { 'Color' => %w(blue), 'Size' => %w(small) } }
            ]
          )

          Workarea.with_config do |config|
            config.option_selections_sort = ->(p, o) { o.sort_by(&:name) }
            config.browse_swatch_option = ->(product, options) { options.first }

            view_model = SwatchesViewModel.wrap(product)
            assert_equal('color', view_model.browse_swatch_option.slug)

            config.browse_swatch_option = ->(product, options) { options.last }

            view_model = SwatchesViewModel.wrap(product)
            assert_equal('size', view_model.browse_swatch_option.slug)
          end
        end
      end
    end
  end
end
