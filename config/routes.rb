Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions
  root to: redirect('sessions/new')
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :cards
  root to: redirect('/cards')

  resources :users
  get 'users/show'
  post 'users/draw'
  post 'cards/deal_all'
  post 'users/update'


  resources :settings
  root :to => redirect('/settings')

end
