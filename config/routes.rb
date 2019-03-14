Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'merchants_search#show'
        get '/find_all', to: 'merchants_search#index'
        get '/random', to: 'merchants_random#show'
      end
      resources :merchants, only: [:index, :show] do
        resources :items, to: 'merchants/merchant_items#index'
        resources :invoices, to: 'merchants/merchant_invoices#index'
        get '/revenue', to: 'merchants/merchant_revenue#show'
      end
      namespace :invoices do
        get '/find', to: 'invoices_search#show'
        get '/find_all', to: 'invoices_search#index'
      end
      resources :invoices, only: [:index, :show]
      resources :customers, only: :index
    end
  end
end
