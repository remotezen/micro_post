class SessionsController < ApplicationController
  def new
  end
  def create
    credential = params[:session][:login]
    user = User.username_or_email(credential)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] ='Invalid credential/password combination'
      render 'new'
    end
  end
end
