Rails.application.routes.draw do
  root 'pages#home'

  get 'contact', to: 'pages#contact'

  resources :articles

  get 'signup' , to: 'users#new'

  resources :users, except: [:new]

end
