module API
  module V1
    class ReleasesController < API::BaseController
      def index
        respond_with current_user.releases.order('id desc').page(params[:page])
      end

      def create
        @release = proxy.releases.build(release_params)
        @release.config = params[:config]
        respond_with :api, :v1, @proxy, @release
      end

      def deploy
        @release = current_user.releases.find(params[:id])
        @release.deploy!
        respond_with :api, :v1, @proxy, @release
      end

      private

      def proxy
        @proxy ||= current_user.proxies.find_by!(subdomain: params[:proxy_id])
      end

      def releases_url
        api_v1_releases_url
      end

      def release_url(release)
        api_v1_release_url(release)
      end

      def release_params
        params.permit(:done)
      end
    end
  end
end
