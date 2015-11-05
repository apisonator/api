module API
  module V1
    class RegistrationsController < API::BaseController

      skip_before_action :verify_authenticity_token
      skip_before_action :authenticate_by_api_key!

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
        params.fetch(:user, {}).permit(:email, :password)
      end
    end
  end
end
