class API::BaseController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :authenticate_by_api_key!

  respond_to :json

  private

  def authenticate_by_api_key!
    @current_user = User.find_by!(api_key: params[:api_key])
  end
end
