require 'test_helper'

module Workarea
  module Storefront
    class SwatchesSystemTest < Workarea::SystemTest
      def test_product_template
        create_swatch(name: 'Red', image: product_image_file)
        create_swatch(name: 'Blue', hex: '0000ff')
        product = create_product(
          template: 'swatches',
          variants: [
            {
              sku: 'SKU1',
              details: { color: 'Red', size: 'Large', material: 'Cotton' }
            },
            {
              sku: 'SKU2',
              details: { color: 'Red', size: 'Small', material: 'Cotton' }
            },
            {
              sku: 'SKU3',
              details: { color: 'Blue', size: 'Small', material: 'Suede' }
            }
          ]
        )

        visit storefront.product_path(product)

        within '.product-details' do
          assert(page.has_selector?('.option-button__image--red'))
          assert(page.has_selector?('.option-button__swatch--blue'))
          assert(page.has_selector?('[style="background-color: #0000ff;"]'))
          assert(page.has_content?('Large'))
          assert(page.has_content?('Small'))
          assert(page.has_content?('Cotton'))
          assert(page.has_content?('Suede'))

          find('.option-button__image--red').click
          assert(page.has_selector?('.option-button__image--red'))
          assert(page.has_selector?('.option-button__swatch--blue'))
          assert(page.has_selector?('[style="background-color: #0000ff;"]'))
          assert(page.has_content?('Large'))
          assert(page.has_content?('Small'))
          assert(page.has_content?('Cotton'))
          assert(page.has_no_content?('Suede'))

          click_link 'Small'
          assert(page.has_selector?('.option-button__image--red'))
          assert(page.has_selector?('.option-button__swatch--blue'))
          assert(page.has_selector?('[style="background-color: #0000ff;"]'))
          assert(page.has_content?('Large'))
          assert(page.has_content?('Small'))
          assert(page.has_content?('Cotton'))
          assert(page.has_no_content?('Suede'))

          find('.option-button__swatch--blue').click
          assert(page.has_selector?('.option-button__image--red'))
          assert(page.has_selector?('.option-button__swatch--blue'))
          assert(page.has_selector?('[style="background-color: #0000ff;"]'))
          assert(page.has_no_content?('Large'))
          assert(page.has_content?('Small'))
          assert(page.has_no_content?('Cotton'))
          assert(page.has_content?('Suede'))

          find('.option-button__swatch--blue').click # to unselect
          assert(page.has_selector?('.option-button__image--red'))
          assert(page.has_selector?('.option-button__swatch--blue'))
          assert(page.has_selector?('[style="background-color: #0000ff;"]'))
          assert(page.has_content?('Large'))
          assert(page.has_content?('Small'))
          assert(page.has_content?('Cotton'))
          assert(page.has_content?('Suede'))

          find('.option-button__swatch--blue').click
          click_link t('workarea.storefront.products.clear_selections')
          assert(page.has_selector?('.option-button__image--red'))
          assert(page.has_selector?('.option-button__swatch--blue'))
          assert(page.has_selector?('[style="background-color: #0000ff;"]'))
          assert(page.has_content?('Large'))
          assert(page.has_content?('Small'))
          assert(page.has_content?('Cotton'))
          assert(page.has_content?('Suede'))
        end

        visit storefront.product_path(product, sku: 'SKU1')
        within '.product-details' do
          assert(page.has_selector?('.option-button__image--red'))
          assert(page.has_no_selector?('.option-button__swatch--blue'))
          assert(page.has_no_selector?('[style="background-color: #0000ff;"]'))
          assert(page.has_content?('Large'))
          assert(page.has_content?('Small'))
          assert(page.has_content?('Cotton'))
          assert(page.has_no_content?('Suede'))
          assert(page.has_selector?('.option-button--red.option-button--active'))
          assert(page.has_selector?('.option-button--large.option-button--active'))
          assert(page.has_selector?('.option-button--cotton.option-button--active'))
        end
      end
    end
  end
end
