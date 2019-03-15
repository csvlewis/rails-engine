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

      namespace :customers do
        get '/find', to: 'customers_search#show'
        get '/find_all', to: 'customers_search#index'
        get '/random', to: 'customers_random#show'
      end
      resources :customers, only: [:index, :show] do
        resources :transactions, to: 'customers/customer_transactions#index'
        resources :invoices, to: 'customers/customer_invoices#index'
      end

      namespace :invoice_items do
        get '/find', to: 'invoice_items_search#show'
        get '/find_all', to: 'invoice_items_search#index'
        get '/random', to: 'invoice_items_random#show'
      end
      resources :invoice_items, only: [:index, :show] do
        resources :item, to: 'invoice_items/invoice_item_item#show'
        resources :invoice, to: 'invoice_items/invoice_item_invoice#show'
      end

      namespace :items do
        get '/find', to: 'items_search#show'
        get '/find_all', to: 'items_search#index'
        get '/random', to: 'items_random#show'
      end
      resources :items, only: [:index, :show] do
        resources :invoice_items, to: 'items/item_invoice_items#index'
        resources :merchant, to: 'items/item_merchant#show'
      end

      namespace :transactions do
        get '/find', to: 'transactions_search#show'
        get '/find_all', to: 'transactions_search#index'
        get '/random', to: 'transactions_random#show'
      end
      resources :transactions, only: [:index, :show]
    end
  end
end
