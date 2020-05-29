class Api::V1::SessionsController < ApplicationController
  def create
    @user = AuthenticateUserHelper.call(params[:email], params[:password])

    if @user.success?
      render json: { token: @user.result }
    else
      render json: { error: @user.errors }, status: :unauthorized
    end
  end

  def destroy
    current_user&.authentication_token = nil
    if current_user&.save
      render status: :ok
    else
      render status: :unauthorized
    end
  end
end