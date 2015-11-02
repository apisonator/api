module API
  module V1
    class SessionsController < API::BaseController

      skip_before_action :verify_authenticity_token
      skip_before_action :authenticate_by_api_key!

      respond_to :json

      def create
        @user = User.find_by!(email: params[:email])
        if @user.valid_password?(params[:password])
          respond_with @user
        else
          render status: :unauthorized, text: {error: "unauthorized"}.to_json
        end
      end

      private

      def user_url(id)
        '/TODO'
      end

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end
