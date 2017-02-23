class UsersController < ApplicationController
  before_action :check_logged_in, only: [:edit, :update]
  before_action :check_user, only: [:show, :edit, :update]

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
      flash[:success] = "Successfully Sign Up!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params.require(:user).permit(:name, :email, :password, :password_confirmation))
      flash[:success] = "Settings updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def check_logged_in
    if !logged_in?
      store_forward_url
      flash[:danger] = "Please log in first!"
      redirect_to login_url
    end
  end

  def check_user
    @user = User.find(params[:id])
    if @user != current_user
      flash[:warning] = "Permission denied"
      redirect_to current_user
    end
  end
end
