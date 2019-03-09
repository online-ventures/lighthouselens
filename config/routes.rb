Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'

  # Basic navigation
  get 'articles', to: 'pages#articles', as: 'articles'
  get 'gallery', to: 'pages#gallery', as: 'gallery'
  get 'contact', to: 'messages#new', as: 'contact'
  get 'about', to: 'messages#new', as: 'about'
  get 'contact/:id', to: 'messages#new', as: 'contact_about_item'

  resources :messages, only: [:new, :create]
  resources :items, only: [:show]
  get 'categories/:id/items', to: 'categories#index', as: 'categories'
end
