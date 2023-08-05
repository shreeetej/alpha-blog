Rails.application.routes.draw do
  root 'pages#home'

  get 'contact', to: 'pages#contact'

  resources :articles, only: [:show]

end
