module API
  module V1
    class ReleasesController < API::BaseController
      def index
        respond_with current_user.releases.order('id desc').page(params[:page])
      end

      def create
        @release = current_user.releases.create(release_params)
        respond_with @release
      end

      def update
        @release = current_user.releases.find(params[:id])
        @release.update_attributes(release_params)
        respond_with @release
      end

      private

      def release_url(release)
        api_v1_release_url(release)
      end

      def release_params
        params.permit(:config, :done)
      end
    end
  end
end
