Rails.application.routes.draw do
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create, :edit]
end
