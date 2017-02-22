Rails.application.routes.draw do
	# set root route
	root 'static_pages#home'
  get '/support', to: 'static_pages#support'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new'

  resources :users
end
