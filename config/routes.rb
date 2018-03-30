Rails.application.routes.draw do
  root 'communities#top'

  get 'auth/:provider/callback', to: 'users#create'
  get 'auth/failure', to: redirect('/')
  delete 'signout',  to: 'sessions#destroy', as: 'signout'
  get    '/index',   to: 'communities#index'
  post   '/search',  to: 'communities#search'
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/thanks',  to: 'charges#thanks'
  get    '/tmp',  to: 'sellers#tmp'
  get    '/cook',   to: 'communities#cook'
  get    '/ambassador',   to: 'communities#ambassador'
  get    '/vision',   to: 'communities#vision'
  get    '/faq',   to: 'communities#faq'
  get    '/company',   to: 'communities#company'
  get    '/terms-of-use',   to: 'communities#terms-of-use'
  get    '/privacy-policy',   to: 'communities#privacy-policy'
  get    '/cancellation-policy',   to: 'communities#cancellation-policy'
  get    '/ask',   to: 'communities#ask'
  get    '/cooking-guide',   to: 'communities#cooking-guide'
  resources :users
  get    '/buy_history',  to: 'users#buy_history'
  resources :tickets do
    collection do
      post 'confirm'
    end
    member do
      patch 'edit_confirm'
    end
    resources :shares, only: [ :destroy ]
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
