ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include ApplicationHelper
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  def is_logged_in?
    !session[:user_id].nil?
  end

def log_in_as(user)
  session[:user_id] = user.id
end

def log_out
  session.delete(:user_id)
end

end

class ActionDispatch::IntegrationTest
 # Log in as a particular user.
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { login: user.username,
                                          password: password,
                                          remember_me: remember_me } }
  end
end
