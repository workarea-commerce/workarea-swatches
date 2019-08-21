module Workarea
  module Storefront
    module SwatchesHelper
      def render_swatch_option(selection, swatch)
        id = selection.optionize

        if swatch&.image?
          image_tag(
            swatch.image.process(:small_thumb).url,
            alt: selection,
            class: "option-button__image option-button__image--#{id}"
          )
        elsif swatch&.hex?
          content_tag(
            :div,
            '',
            class: "option-button__swatch option-button__swatch--#{id}",
            style: "background-color: #{swatch.hex};"
          )
        end
      end

      def render_browse_swatch(selection, swatch)
        id = selection.optionize

        if swatch&.image?
          image_tag(
            swatch.image.process(:small_thumb).url,
            alt: selection,
            class: [
              'swatch-options__swatch-button-image',
              "swatch-options__swatch-button-image--#{id}"
            ].join(' ')
          )
        elsif swatch&.hex?
          content_tag(
            :div,
            '',
            class: [
              'swatch-options__swatch-button',
              "swatch-options__swatch-button--#{id}"
            ].join(' '),
            style: "background-color: #{swatch.hex};"
          )
        else
          content_tag(
            :div,
            selection,
            class: 'swatch-options__swatch-button-text'
          )
        end
      end

      def render_swatch_facet(selection)
        id = selection.optionize

        @swatches_cache ||= Catalog::Swatch.all.to_a
        swatch = @swatches_cache.detect { |s| s.id == id }
        class_list = "swatch-facet swatch-facet--#{id}"

        if swatch&.image?
          image_tag(
            swatch.image.process(:facet_swatch).url,
            alt: selection,
            class: "#{class_list} swatch-facet--image"
          )
        elsif swatch&.hex?
          content_tag(
            :div,
            '',
            class: "#{class_list} swatch-facet--hex",
            style: "background-color: #{swatch.hex};"
          )
        else
          content_tag(
            :span,
            '',
            class: "#{class_list} swatch-facet--empty"
          )
        end
      end
    end
  end
end
