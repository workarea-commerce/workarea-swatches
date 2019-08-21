module Workarea
  module Search
    module SwatchedFacets
      def facets
        @swatched_facets ||= begin
          swatch_facet_names = swatched_facets.map(&:name)
          without_swatches = super.reject { |f| f.name.in?(swatch_facet_names) }
          swatched_facets + without_swatches
        end
      end

      def swatched_facets
        Search::Settings.current.swatch_facets.map do |swatch_facet|
          SwatchesFacet.new(self, swatch_facet)
        end
      end
    end
  end
end
