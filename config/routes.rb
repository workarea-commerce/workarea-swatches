Workarea::Admin::Engine.routes.draw do
  scope '(:locale)', constraints: Workarea::I18n.routes_constraint do
    resources :catalog_swatches, except: [:new, :show, :edit]

    resources :catalog_products, only: [] do
      resources :swatches,
        except: [:new, :show, :edit],
        controller: 'catalog_product_swatches'
    end
  end
end

Workarea::Storefront::Engine.routes.draw do
  scope '(:locale)', constraints: Workarea::I18n.routes_constraint do
    resources :products, only: [] do
      member { get 'summary' }
    end
  end
end
