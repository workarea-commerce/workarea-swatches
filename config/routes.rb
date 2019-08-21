Workarea::Admin::Engine.routes.draw do
  resources :catalog_swatches, except: [:new, :show, :edit]

  resources :catalog_products, only: [] do
    resources :swatches,
      except: [:new, :show, :edit],
      controller: 'catalog_product_swatches'
  end
end

Workarea::Storefront::Engine.routes.draw do
  resources :products, only: [] do
    member { get 'summary' }
  end
end
