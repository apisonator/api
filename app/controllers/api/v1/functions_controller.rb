module API
  module V1
    class FunctionsController < API::BaseController

      def index
        get_release
        respond_with @release.functions.order('position asc').page(params[:page])
      end

      def show
        get_release
        respond_with @release.functions.find(params[:id])
      end

      def create
        get_release
        @function = @release.functions.create(function_params)
        respond_with @function
      end

      private

      def get_release
        @release = current_user.releases.find(params[:release_id])
      end

      def function_url(id)
        api_v1_function_url(id)
      end

      def function_params
        params.permit(:name, :content, :position)
      end
    end
  end
end
