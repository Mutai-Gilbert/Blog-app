class ApplicationController < ActionController::Base
  def current_user
    User.find_by_id(1)
  end
end
