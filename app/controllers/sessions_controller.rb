class SessionsController < ApplicationController
  def new
  end

  def create
  	signin_email = params[:session][:email].downcase
  	signin_pass = params[:session][:password]
  	user = User.find_by(email: signin_email)
  	if user && user.authenticate(signin_pass)
      if user.activated?
    		log_in user
    		if params[:session][:remember_me] == 1
  	  		remember_user user
  	  	else
  	  		forget_user user
  	  	end
  		  redirect_back_or user
      else
        flash[:warning] = "Account not activated, please check email."
        redirect_to root_url
      end
  	else
      # flash.now use render, it is not a new request
      # flash use redirect_to, it is a new request
      flash.now[:danger] = "Incorrect email or password!"
  		render 'new'
  	end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end
end
