require 'sidekiq/web'

Rails.application.routes.draw do

  # Sidekiq
  mount Sidekiq::Web => '/sidekiq', :constraints => SidekiqConstraint.new

  # Auth0
  get 'login', to: redirect('auth/auth0')
  get 'logout', to: 'auth0#logout'
  get 'auth/auth0/callback', to: 'auth0#callback', as: 'auth_callback'
  get 'auth/failure', to: 'auth0#failure', as: 'auth_failure'
  get 'auth/unauthorized', to: 'auth0#unauthorized', as: 'unauthorized'

  # Support old php routes for a while.  Redirect them.
  get 'index.php', to: redirect('/')
  get 'items/list.php', to: redirect { |_p, r| "categories/#{r.GET[:id]}/items" }
  get 'items/index.php', to: redirect { |_p, r| "items/#{r.GET[:id]}" }

  get 'admin', to: 'items#index', as: 'admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'

  # Basic navigation
  get 'articles', to: 'pages#articles', as: 'articles'
  get 'gallery', to: 'pages#gallery', as: 'gallery'
  get 'contact', to: 'messages#new', as: 'contact'
  get 'about', to: 'messages#new', as: 'about'
  get 'contact/:id', to: 'messages#new', as: 'contact_about_item'

  # Inquiries
  get 'messages', to: 'messages#new', as: 'new_message'
  post 'inquiries', to: 'messages#create', as: 'inquiries'

  # Items
  resources :items, only: [:show]
  get 'categories/:id/items', to: 'categories#index', as: 'categories'

  # Match everything else. Say not found.
  get '*path', to: 'pages#not_found', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
