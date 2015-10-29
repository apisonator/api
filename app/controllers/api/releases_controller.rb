class API::ReleasesController < API::BaseController

  def index
    respond_with current_user.releases.order('id desc').page(params[:page])
  end

  def create
    @release = current_user.releases.create(release_params)
    respond_with @release
  end

  private

  def release_url(release)
    api_release_url(release)
  end

  def release_params
    params.permit(:config)
  end
end
