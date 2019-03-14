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
        get '/random', to: 'invoices_random#show'
      end
      resources :invoices, only: [:index, :show] do
        resources :transactions, to: 'invoices/invoice_transactions#index'
        resources :invoice_items, to: 'invoices/invoice_invoice_items#index'
        resources :items, to: 'invoices/invoice_items#index'
        resources :customer, to: 'invoices/invoice_customer#show'
        resources :merchant, to: 'invoices/invoice_merchant#show'
      end
      resources :customers, only: [:index, :show]
    end
  end
end
