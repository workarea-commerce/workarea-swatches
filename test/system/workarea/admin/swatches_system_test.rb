require 'test_helper'

module Workarea
  module Admin
    class SwatchesSystemTest < SystemTest
      include Admin::IntegrationTest

      def test_managing
        visit admin.catalog_swatches_path
        assert(
          page.has_content?(
            t('workarea.admin.catalog_swatches.index.no_swatches')
          )
        )

        fill_in 'swatch[name]', with: 'Red'
        fill_in 'swatch[hex]', with: '000000'
        click_button 'save_new_swatch'

        assert(page.has_content?('Success'))
        assert(page.has_content?('Red'))

        click_button 'remove_swatch'
        assert(page.has_content?('Success'))
        assert(page.has_no_content?('Red'))
        assert(
          page.has_content?(
            t('workarea.admin.catalog_swatches.index.no_swatches')
          )
        )

        fill_in 'settings[swatch_facets_list]', with: 'Color, Material'
        click_button 'save_settings'
        assert_current_path(admin.catalog_swatches_path)
        assert(page.has_content?('Success'))
      end

      def test_managing_on_products
        product = create_product
        visit admin.catalog_product_swatches_path(product)

        fill_in 'swatch[name]', with: 'Blue'
        attach_file 'swatch[image]', product_image_file_path
        click_button 'save_new_swatch'

        assert_equal(admin.catalog_product_swatches_path(product), current_path)
        assert(page.has_content?('Success'))
        assert(page.has_content?('Blue'))

        click_button 'remove_swatch'

        assert_equal(admin.catalog_product_swatches_path(product), current_path)
        assert(page.has_content?('Success'))
        assert(page.has_no_content?('Blue'))
      end
    end
  end
end
