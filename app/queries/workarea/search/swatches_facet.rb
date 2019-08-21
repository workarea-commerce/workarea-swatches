module Workarea
  module Search
    class SwatchesFacet < TermsFacet
      # This class exists so we have a specific facet type to allow rendering
      # a different partial in the storefront to give us the opportunity to show
      # the swatches

      def type
        :swatches
      end
    end
  end
end
