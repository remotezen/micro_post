class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    #byebug
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Micropost Application"
      redirect_to @user
    else
      flash[:error] = "There was a problem with your submission"
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
end
