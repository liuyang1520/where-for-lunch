module SessionsHelper
	def log_in(user)
		session[:user_id] = user.id
	end

	def current_user
		# Define @current_user only saves database visit within
		# the same page
		# Since HTTP is stateless, so cannot store @current_user
		# for all requests of a user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def logged_in?
		!current_user.nil?
	end

	def log_out
		session.delete(:user_id)
		@current_user = nil
	end
end
