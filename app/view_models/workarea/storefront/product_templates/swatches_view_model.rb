module Workarea
  module Storefront
    class ProductTemplates::SwatchesViewModel < ProductViewModel
      include OptionSetViewModel

      def images_by_option
        @images_by_option ||= model
          .images
          .reject { |i| i.option.blank? }
          .group_by { |i| i.option.optionize }
          .with_indifferent_access
          .transform_keys(&:optionize)
      end

      def swatches_by_option
        @swatches_by_option ||= Hash[swatches_with_overrides.map { |s| [s.id, s] }]
      end

      def browse_link_options
        return super unless current_browse_selection.present?
        super.merge(browse_swatch_option.slug => current_browse_selection)
      end

      def browse_swatch_option
        @browse_swatch_option ||=
          Workarea.config.browse_swatch_option.call(self, options_for_selection)
      end

      def display_browse_swatches?
        return false if model.try(:browse_option).present?
        browse_swatch_option.present?
      end

      def current_browse_selection
        return if browse_swatch_option.blank?
        options[browse_swatch_option.slug]
      end

      def current_browse_selection?(selection)
        current_browse_selection == selection
      end

      private

      def swatches_with_overrides
        (global_swatches + model.swatches).map do |swatch|
          override_swatch = model.swatches.detect { |s| s.id == swatch.id }
          override_swatch || swatch
        end
      end

      def global_swatches
        @global_swatches ||= Catalog::Swatch.all.to_a
      end
    end
  end
end
