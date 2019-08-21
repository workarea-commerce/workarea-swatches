require 'test_helper'

module Workarea
  module Admin
    class ProductSwatchesIntegrationTest < Workarea::IntegrationTest
      include Admin::IntegrationTest
      setup :set_product

      def set_product
        @product = create_product
      end

      def test_creates_a_swatch
        post admin.catalog_product_swatches_path(@product),
             params: { swatch: { image: product_image_file, name: 'blue' } }

        @product.reload
        assert_equal(1, @product.swatches.length)
        assert_equal('blue', @product.swatches.first.id)
      end

      def test_update
        swatch = @product.swatches.create!(name: 'Red', hex: '000000')

        patch admin.catalog_product_swatch_path(@product, swatch),
          params: { swatch: { name: 'Redder', hex: '111111' } }

        assert_equal(1, @product.reload.swatches.count)
        swatch = @product.swatches.find('red')
        assert_equal('Redder', swatch.name)
        assert_equal('#111111', swatch.hex)
      end

      def test_destroys_a_swatch
        swatch = @product.swatches.create!(image: product_image_file, name: 'blue')
        delete admin.catalog_product_swatch_url(@product, swatch)

        @product.reload
        assert_empty(@product.swatches)
      end
    end
  end
end
