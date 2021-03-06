module SessionsHelper
	def log_in(user)
		session[:user_id] = user.id
	end

	def current_user
		# Define @current_user only saves database visit within
		# the same page
		# Since HTTP is stateless, so cannot store @current_user
		# for all requests of a user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(:remember, cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	def logged_in?
		!current_user.nil?
	end

	def is_admin?
		current_user.admin?
	end

	def log_out
		forget_user(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	def remember_user(user)
		user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget_user(user)
  	user.forget
  	cookies.delete(:user_id)
  	cookies.delete(:remember_token)
  end

  def store_forward_url
  	session[:forwarding_url] = request.original_url if request.get?
  end

  def redirect_back_or(redirect_url)
  	redirect_to(session[:forwarding_url] || redirect_url)
  	session.delete(:forwarding_url)
  end
end
