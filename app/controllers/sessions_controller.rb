class SessionsController < ApplicationController
  include ApplicationHelper

  def new
  end

  def create
    credential = params[:session][:login]
    @user = User.username_or_email(credential)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
       # __debug__ params[:session][:remember_me]
        params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        message = "Account not activated. "
        message += "Check your email for account activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] ='Invalid credential/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
