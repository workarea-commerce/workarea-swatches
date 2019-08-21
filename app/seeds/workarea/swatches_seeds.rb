module Workarea
  class SwatchesSeeds
    COLORS = {
      red: '#f44336',
      pink: '#e91e63',
      purple: '#9c27b0',
      deep_purple: '#673ab7',
      indigo: '#3f51b5',
      blue: '#2196f3',
      light_blue: '#03a9f4',
      cyan: '#00bcd4',
      teal: '#009688',
      green: '#4caf50',
      light_green: '#8bc34a',
      lime: '#cddc39',
      yellow: '#ffeb3b',
      amber: '#ffc107',
      orange: '#ff9800',
      deep_orange: '#ff5722',
      brown: '#795548',
      grey: '#9e9e9e',
      blue_grey: '#607d8b',
      white: '#ffffff',
      black: '#000000'
    }

    def perform
      puts 'Adding swatches...'

      COLORS.each do |name, hex|
        Catalog::Swatch.create!(name: name.to_s.titleize, hex: hex)
      end

      Search::Settings.current.update_attributes!(swatch_facets: ['Color'])
    end
  end
end
