class SessionsController < ApplicationController
  def new
  end

  def create
  	signin_email = params[:session][:email].downcase
  	signin_pass = params[:session][:password]
  	user = User.find_by(email: signin_email)
  	if user && user.authenticate(signin_pass)
  		log_in user
  		redirect_to user
  	else
  		render 'new'
  	end
  end

  def destroy
  	log_out
  	redirect_to root_url
  end
end
