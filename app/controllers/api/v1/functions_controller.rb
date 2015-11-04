module API
  module V1
    class FunctionsController < API::BaseController

      def index
        get_release
        @functions = @release.functions.order('position asc').page(params[:page])
        respond_with :api, :v1, @release, @functions
      end

      def show
        get_release
        @function = @release.functions.find(params[:id])
        respond_with :api, :v1, @release, @function
      end

      def create
        get_release
        @function = @release.functions.create(function_params)
        respond_with :api, :v1, @release, @function
      end

      private

      def get_release
        @release = current_user.releases.find(params[:release_id])
      end

      def function_params
        params.permit(:name, :content, :position)
      end
    end
  end
end
