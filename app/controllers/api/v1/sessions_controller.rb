
class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
  protect_from_forgery with: :null_session

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      current_token = request.env["warden-jwt_auth.token"]
      render json: { message: "Successful login", token: current_token }, status: :ok
    else
      render json: { message: "Invalid credentials" }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    if current_user
      render json: { message: "Successful logout" }, status: :ok
    else
      render json: { message: "Invalid Token" }, status: :unauthorized
    end
  end
end
