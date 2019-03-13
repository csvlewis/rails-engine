Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find_all', to: 'merchants_search#index'
        get '/find', to: 'merchants_search#show'
        get '/random', to: 'merchants_random#show'
      end
      resources :merchants, only: [:index, :show] do
        resources :items, to: 'merchants/merchant_items#index'
        resources :invoices, to: 'merchants/merchant_invoices#index'
        get '/revenue', to: 'merchants/merchant_revenue#show'
      end
      resources :customers, only: :index
    end
  end
end
