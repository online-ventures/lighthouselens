Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'

  # Basic navigation
  get 'articles', to: 'pages#articles'
  get 'gallery', to: 'pages#gallery'
  get 'contact', to: 'messages#new'
  get 'about', to: 'messages#new'

  resources :messages, only: [:new, :create]
end
