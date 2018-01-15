Rails.application.routes.draw do
  root 'communities#index'

  post   '/search',  to: 'communities#search'
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :tickets
  # resouces :talks, only: [:index, :show]

end
