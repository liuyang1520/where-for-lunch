Rails.application.routes.draw do
	# set root route
	root 'static_pages#home'

  get 'static_pages/home'

  get 'static_pages/support'

  get 'static_pages/about'

  get 'static_pages/contact'

  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
