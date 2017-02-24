class UsersController < ApplicationController
  before_action :check_logged_in, only: [:show, :edit, :update, :index, :destroy]
  before_action :check_user, only: [:show, :edit, :update]
  before_action :check_admin, only: [:index, :destroy]

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def create
  	user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	@user = User.new(user_params)
  	if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check email for activation!"
  		redirect_to root_url
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

  def destroy
    user = User.find(params[:id])
    flash[:success] = "Delete #{user.name}"
    user.destroy
    redirect_to users_url
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
    if !is_admin? && @user != current_user
      flash[:warning] = "Permission denied, can only view people in the same group"
      redirect_to current_user
    end
  end

  def check_admin
    if !is_admin?
      flash[:warning] = "Permission denied, need admin user"
      redirect_to current_user
    end
  end
end
