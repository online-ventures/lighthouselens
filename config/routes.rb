Rails.application.routes.draw do
  # Support old php routes for a while.  Redirect them.
  get 'index.php', to: redirect('/')
  get 'items/list.php', to: redirect { |_p, r| "categories/#{r.GET[:id]}/items" }
  get 'items/index.php', to: redirect { |_p, r| "items/#{r.GET[:id]}" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'

  # Basic navigation
  get 'articles', to: 'pages#articles', as: 'articles'
  get 'gallery', to: 'pages#gallery', as: 'gallery'
  get 'contact', to: 'messages#new', as: 'contact'
  get 'about', to: 'messages#new', as: 'about'
  get 'contact/:id', to: 'messages#new', as: 'contact_about_item'

  # Items, lists, resources
  resources :messages, only: [:new, :create]
  resources :items, only: [:show]
  get 'categories/:id/items', to: 'categories#index', as: 'categories'

  # Match everything else. Say not found.
  get '*path', to: 'pages#not_found', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
