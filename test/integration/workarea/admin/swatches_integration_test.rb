require 'test_helper'

module Workarea
  module Admin
    class SwatchesIntegrationTest < Workarea::IntegrationTest
      include Admin::IntegrationTest

      def test_create
        post admin.catalog_swatches_path,
          params: { swatch: { name: 'Red', hex: '000000' } }

        assert_equal(1, Catalog::Swatch.count)
        swatch = Catalog::Swatch.find('red')
        assert_equal('Red', swatch.name)
        assert_equal('#000000', swatch.hex)
      end

      def test_update
        swatch = create_swatch(name: 'Red', hex: '000000')

        patch admin.catalog_swatch_path(swatch),
          params: { swatch: { name: 'Redder', hex: '111111' } }

        assert_equal(1, Catalog::Swatch.count)
        swatch = Catalog::Swatch.find('red')
        assert_equal('Redder', swatch.name)
        assert_equal('#111111', swatch.hex)
      end

      def test_destroy
        swatch = create_swatch(name: 'Red', hex: '000000')
        delete admin.catalog_swatch_path(swatch)
        assert_equal(0, Catalog::Swatch.count)
      end
    end
  end
end
