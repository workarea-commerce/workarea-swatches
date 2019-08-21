Workarea.configure do |config|
  config.product_templates << :swatches

  config.seeds.insert_after(
    'Workarea::ProductsSeeds',
    'Workarea::SwatchesSeeds'
  )

  # Determines which option is used for displaying swatches on
  # browse pages. Return the option you would like to be used. We pass the
  # product in case there are other factors to base sorting on.
  config.browse_swatch_option = ->(product, options) { options.first }
end

Workarea.append_partials(
  'admin.catalog_menu',
  'workarea/admin/catalog_swatches/primary_navigation'
)

Workarea.append_partials(
  'admin.catalog_product_cards',
  'workarea/admin/catalog_products/swatches_card'
)

Workarea::Plugin.append_stylesheets(
  'storefront.components',
  'workarea/storefront/swatches/components/option_button',
  'workarea/storefront/swatches/components/swatch_facet',
  'workarea/storefront/swatches/components/swatch_options'
)

Workarea::Plugin.append_javascripts(
  'storefront.modules',
  'workarea/storefront/swatches/modules/product_summary_swatches'
)

Workarea.append_partials(
  'storefront.product_summary',
  'workarea/storefront/products/swatch_summary'
)
