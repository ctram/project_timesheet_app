class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in? # methods thats are passed as arguments to the helper_method() will be available in the VIEW templates as well as all children classes of ApplicationController.

  def current_user
    if logged_in?
      current_user ||= User.find(session[:user_id])
    else
      nil
    end
  end

  def logged_in?
    session[:user_id] != nil
  end
end
