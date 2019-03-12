Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find_all', to: 'merchants_search#index'
        get '/find', to: 'merchants_search#show'
        get '/random', to: 'merchants_random#show'
      end
      resources :merchants, only: [:index, :show] do
        resources 'items', to: 'merchants/merchants_item#index'
      end
      resources :customers, only: :index
    end
  end
end
