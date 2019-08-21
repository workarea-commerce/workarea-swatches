processors = Dragonfly.app(:workarea).processors.names

Dragonfly.app(:workarea).configure do
  unless processors.include?(:facet_swatch)
    processor :facet_swatch do |content|
      content.process!(:encode, :jpg, Workarea.config.jpg_encode_options)
      content.process!(:thumb, '20x')
      content.process!(:optim)
    end
  end
end
