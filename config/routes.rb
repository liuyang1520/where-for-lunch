Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

	# set root route
	root 'static_pages#home'
  get '/support', to: 'static_pages#support'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end