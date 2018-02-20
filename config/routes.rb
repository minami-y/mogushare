Rails.application.routes.draw do
  root 'communities#top'

  get 'auth/:provider/callback', to: 'users#create'
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'sessions#destroy', as: 'signout'
  get    '/index',     to: 'communities#index'
  post   '/search',  to: 'communities#search'
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/thanks',  to: 'charges#thanks'
  resources :users
  resources :tickets do
    collection do
      post 'confirm'
    end
  end
  resources :talks
  resources :sellers
  resources :charges do
    collection do
      post 'confirm'
    end
  end
  # post 'chareges/new' => 'chareges#new'
end
