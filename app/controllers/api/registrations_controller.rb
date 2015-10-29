class API::RegistrationsController < ApplicationController

  skip_before_action :verify_authenticity_token

  respond_to :json

  def create
    @user = User.create(user_params)
    respond_with @user
  end

  private

  def user_url(id)
    '/TODO'
  end

  def user_params
    params.permit(:email, :password)
  end
end
