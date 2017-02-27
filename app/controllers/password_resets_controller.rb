class PasswordResetsController < ApplicationController
	before_action :valid_user, only: [:edit, :update]
	before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def edit
  end

  def create
  	@user = User.find_by(email: params[:password_reset][:email].downcase)
  	if @user
  		@user.send_password_reset_email
  		flash[:info] = "Please check your email to reset the password!"
  		redirect_to root_url
  	else
  		flash.now[:warning] = "No match email in database!"
  		render "new"
  	end
  end

  def update
  	if params[:user][:password].empty?
  		@user.errors.add(:password, "Cannot be empty!")
  		render 'edit'
  	elsif @user.update_attributes(params.require(:user).permit(:password, :password_confirmation))
  		log_in @user
  		flash[:success] = "Password is reset"
  		redirect_to @user
  	else
  		render 'edit'
  	end
  end

  private
  	def valid_user
  		@user = User.find_by(email: params[:email])
  		unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
  		end
  	end

  	def check_expiration
  		if @user.password_reset_expired?
  			flash[:warning] = "Password reset link has expired!"
  			redirect_to new_password_reset_url
  		end
  	end
end
