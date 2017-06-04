class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :set_cache_buster

  helper_method :current_user?

  def current_user?(user)
    current_user == user
  end

  # def set_cache_buster
  #   response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
  #   response.headers["Pragma"] = "no-cache"
  #   response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  # end

end
