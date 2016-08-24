class UsersController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :index, :edit, :update,
  :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  include SessionsHelper

  def new
    @user = User.new
  end


  def following
    @title  = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end
   def destroy
     @user = User.find(params[:id]).destroy
     flash[:success] = "User deleted"
     redirect_to users_url
   end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated?
    #byebug
  end
  #Remember there is a hybrid login method(email and username combined)

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account"
      redirect_to root_url
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

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def correct_user
    user = User.find(params[:id])
   redirect_to login_url unless (user == current_user)
  end

end
