class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update, :show]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    #byebug
  end
=begin
  Remember there is a hybrid login method
=end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Micropost Application"
      redirect_to @user
    else
      flash[:error] = "There was a problem with your submission"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end




  def user_params
    params.require(:user).permit(:name, :username, :email,
                                 :password, :password_confirmation)
  end
  private
  def correct_user
    user = User.find(params[:id])
   redirect_to login_url unless (user == current_user)
  end
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      #in case the user has forgotten to login
      #store location in the sessions hash as
      redirect_to login_url
    end
  end
end
