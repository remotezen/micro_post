class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
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
