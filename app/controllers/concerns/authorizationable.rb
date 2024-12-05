module Authorizationable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from CanCan::AccessDenied do |exception|
      exception.default_message = "You are not authorized to perform this task"
      respond_to do |format|
        format.json { head :forbidden }
        format.html { redirect_back(fallback_location: root_path, alert: exception.message) }
      end
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :role ])
      devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
    end
  end
end