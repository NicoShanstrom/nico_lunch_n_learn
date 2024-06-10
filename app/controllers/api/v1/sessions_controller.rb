class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: UserSerializer.new(user).serializable_hash, status: :ok
    else
      render json: { errors: ["Incorrect email and/or password"] }, status: :bad_request
    end
  end
end