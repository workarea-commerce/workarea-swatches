json.type facet.type
json.name facet.name
json.display_name facet.display_name

json.results facet.results do |name, count|
  json.name name
  json.count count

  @swatches_cache ||= Workarea::Catalog::Swatch.all.to_a
  swatch = @swatches_cache.detect { |s| s.id == name.systemize }

  if swatch&.image?
    json.swatch_image swatch.image.process(:facet_swatch).url
  elsif swatch&.hex?
    json.swatch_hex swatch.hex
  end
end
