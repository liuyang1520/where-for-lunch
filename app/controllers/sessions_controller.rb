class SessionsController < ApplicationController
  def new
  end

  def create
  	signin_email = params[:session][:email].downcase
  	signin_pass = params[:session][:password]
  	user = User.find_by(email: signin_email)
  	if user && user.authenticate(signin_pass)
  		log_in user
  		if params[:session][:remember_me] == 1
	  		remember_user user
	  	else
	  		forget_user user
	  	end
  		redirect_back_or user
  	else
  		render 'new'
  	end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end
end
