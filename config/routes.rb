Rails.application.routes.draw do
  get 'users/new'

  root 'communities#index'

  get    '/search',  to: 'communities#search'
  get    '/signup',  to: 'users#new'
  # get    '/login',   to: 'sessions#new'
  # post   '/login',   to: 'sessions#create'
  # delete '/logout',  to: 'sessions#destroy'
  # resouces :users
  # resouces :tickets
  # resouces :talks, only: [:index, :show]

end
