Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cards
  root to: redirect('/cards')

  resources :users
  get 'users/show'
  post 'users/draw'
  post 'cards/deal_all'
  post 'users/discard'

  resources :settings
  root :to => redirect('/settings')

end
