Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find_all', to: 'merchants_search#index'
      get '/merchants/find', to: 'merchants_search#show'
      resources :customers, only: :index
      resources :merchants, only: [:index, :show]
    end
  end
end
