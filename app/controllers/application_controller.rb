class ApplicationController < ActionController::Base
  include Authorizationable

  allow_browser versions: :modern
  protect_from_forgery with: :exception
end
