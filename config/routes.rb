Rails.application.routes.draw do
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
end