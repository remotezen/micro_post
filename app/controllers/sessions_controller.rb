class SessionsController < ApplicationController
  def new
  end
  def create
    credential = params[:session][:login].downcase
    user = User.find_by(email: credential ) ||
    User.find_by(username: credential)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] ='Invalid credential/password combination'
      render 'new'
    end
  end
end
