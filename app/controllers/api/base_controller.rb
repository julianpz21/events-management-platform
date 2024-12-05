class Api::BaseController < ActionController::API
  include Authorizationable

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: "Access Denied: #{exception.message}" }, status: :forbidden
  end
end
